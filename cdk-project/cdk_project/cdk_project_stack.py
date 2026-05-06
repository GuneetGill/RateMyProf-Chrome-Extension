from __future__ import annotations

"""
AWS CDK stack for the RateMyProf API.

High-level layout:
- VPC with public + isolated subnets (no NAT)
- Private RDS Postgres (reachable only from in-VPC compute)
- Lambda (FastAPI via Mangum) behind API Gateway
- Optional one-off ECS Fargate task for scraping/population
"""

from pathlib import Path

from aws_cdk import (
    CfnOutput,
    Duration,
    RemovalPolicy,
    Stack,
    aws_apigateway as apigateway,
    aws_ec2 as ec2,
    aws_ecr_assets as ecr_assets,
    aws_ecs as ecs,
    aws_logs as logs,
    aws_iam as iam,
    aws_lambda as lambda_,
    aws_rds as rds,
)
from constructs import Construct


class CdkProjectStack(Stack):
    def __init__(self, scope: Construct, construct_id: str, **kwargs) -> None:
        super().__init__(scope, construct_id, **kwargs)

        repo_root = Path(__file__).resolve().parents[2]

        isolated_subnets = ec2.SubnetSelection(subnet_type=ec2.SubnetType.PRIVATE_ISOLATED)

        vpc = ec2.Vpc(
            self,
            "RmpVpc",
            # RDS DBSubnetGroup requires subnets in at least 2 AZs.
            # Subnets themselves are free; this does not enable Multi-AZ RDS.
            max_azs=2,
            # Avoid NAT Gateway to reduce cost. Anything that needs to call AWS APIs
            # from inside the VPC must use VPC endpoints instead.
            nat_gateways=0,
            subnet_configuration=[
                ec2.SubnetConfiguration(
                    name="public", subnet_type=ec2.SubnetType.PUBLIC
                ),
                ec2.SubnetConfiguration(
                    name="private-isolated", subnet_type=ec2.SubnetType.PRIVATE_ISOLATED
                ),
            ],
        )

        # Security groups
        lambda_sg = ec2.SecurityGroup(
            self, "LambdaSG", vpc=vpc, allow_all_outbound=True
        )
        db_sg = ec2.SecurityGroup(self, "DbSG", vpc=vpc, allow_all_outbound=True)
        db_sg.add_ingress_rule(
            peer=lambda_sg,
            connection=ec2.Port.tcp(5432),
            description="Allow Lambda to access Postgres",
        )

        populator_sg = ec2.SecurityGroup(
            self, "PopulatorSG", vpc=vpc, allow_all_outbound=True
        )
        db_sg.add_ingress_rule(
            peer=populator_sg,
            connection=ec2.Port.tcp(5432),
            description="Allow ECS populator task access to Postgres",
        )
        # Interface VPC endpoints use the same SG; allow HTTPS from Lambda ENIs to endpoint ENIs.
        lambda_sg.add_ingress_rule(
            peer=lambda_sg,
            connection=ec2.Port.tcp(443),
            description="Allow Lambda to reach Secrets Manager / CloudWatch Logs VPC endpoints",
        )

        # IAM
        lambda_role = iam.Role(
            self,
            "LambdaExecutionRole",
            assumed_by=iam.ServicePrincipal("lambda.amazonaws.com"),
            managed_policies=[
                iam.ManagedPolicy.from_aws_managed_policy_name(
                    "service-role/AWSLambdaVPCAccessExecutionRole"
                ),
                iam.ManagedPolicy.from_aws_managed_policy_name(
                    "service-role/AWSLambdaBasicExecutionRole"
                ),
            ],
        )

        # Without NAT, the Lambda (in isolated subnets) needs VPC interface endpoints
        # to talk to AWS APIs like Secrets Manager and CloudWatch Logs.
        vpc.add_interface_endpoint(
            "SecretsManagerVpce",
            service=ec2.InterfaceVpcEndpointAwsService.SECRETS_MANAGER,
            subnets=isolated_subnets,
            security_groups=[lambda_sg],
        )
        vpc.add_interface_endpoint(
            "CloudWatchLogsVpce",
            service=ec2.InterfaceVpcEndpointAwsService.CLOUDWATCH_LOGS,
            subnets=isolated_subnets,
            security_groups=[lambda_sg],
        )

        # RDS safety notes:
        # - Run `cdk diff` before deploy. If the diff shows DB instance "[replacement]",
        #   STOP — replacement creates a new empty instance.
        # - removal_policy=RETAIN: stack delete does NOT delete the DB (you clean up in console).
        # - deletion_protection: accidental DeleteDB is blocked until disabled in RDS console.
        #
        # Do not set database_name here: CloudFormation cannot change DBName in place;
        # adding it later forces RDS replacement (data loss). Default DB is `postgres`.
        db = rds.DatabaseInstance(
            self,
            "RmpPostgres",
            engine=rds.DatabaseInstanceEngine.postgres(
                version=rds.PostgresEngineVersion.VER_16_3
            ),
            vpc=vpc,
            vpc_subnets=isolated_subnets,
            security_groups=[db_sg],
            credentials=rds.Credentials.from_generated_secret("postgres"),
            # Smallest practical dev settings
            allocated_storage=20,
            instance_type=ec2.InstanceType.of(
                ec2.InstanceClass.BURSTABLE3, ec2.InstanceSize.MICRO
            ),
            multi_az=False,
            publicly_accessible=False,
            backup_retention=Duration.days(0),
            deletion_protection=True,
            delete_automated_backups=False,
            removal_policy=RemovalPolicy.RETAIN,
        )

        if db.secret:
            db.secret.grant_read(lambda_role)
            # Keep credentials if the stack is deleted (matches RETAIN on the instance).
            db.secret.apply_removal_policy(RemovalPolicy.RETAIN)

        # ---- One-off populator job (ECS Fargate) ----
        # Runs inside the VPC so it can write to private RDS.
        # Runs in a PUBLIC subnet with a public IP so it can scrape the internet without NAT.
        cluster = ecs.Cluster(self, "PopulatorCluster", vpc=vpc)

        populator_task_role = iam.Role(
            self,
            "PopulatorTaskRole",
            assumed_by=iam.ServicePrincipal("ecs-tasks.amazonaws.com"),
        )
        if db.secret:
            db.secret.grant_read(populator_task_role)

        populator_task = ecs.FargateTaskDefinition(
            self,
            "PopulatorTaskDef",
            cpu=1024,
            memory_limit_mib=2048,
            task_role=populator_task_role,
        )

        populator_image = ecs.ContainerImage.from_asset(
            directory=str(repo_root),
            file="Dockerfile.scraper",
            platform=ecr_assets.Platform.LINUX_AMD64,
        )

        populator_task.add_container(
            "populator",
            image=populator_image,
            logging=ecs.LogDrivers.aws_logs(
                stream_prefix="populator",
                log_retention=logs.RetentionDays.ONE_WEEK,
            ),
            environment={
                "SECRET_NAME": db.secret.secret_name if db.secret else "",
                "CHROMEDRIVER_PATH": "/usr/bin/chromedriver",
            },
            command=["python", "populate/populate_prof_id.py"],
        )

        # ---- API Lambda (FastAPI container) ----
        api_lambda = lambda_.DockerImageFunction(
            self,
            "RmpApiLambda",
            # Default Lambda arch is x86_64. Docker on Apple Silicon often builds arm64
            # unless you pin the platform — mismatch surfaces as Runtime.InvalidEntrypoint.
            architecture=lambda_.Architecture.X86_64,
            code=lambda_.DockerImageCode.from_image_asset(
                directory=str(repo_root),
                platform=ecr_assets.Platform.LINUX_AMD64,
                exclude=[
                    # Prevent recursive asset packaging + keep image small
                    "cdk-project/cdk.out",
                    "cdk-project/.venv",
                    "cdk-project/.cache",
                    "venv",
                    "**/__pycache__",
                    "**/*.pyc",
                    ".git",
                    ".DS_Store",
                    "chrome-extention",
                ],
            ),
            timeout=Duration.seconds(30),
            memory_size=512,
            vpc=vpc,
            vpc_subnets=isolated_subnets,
            security_groups=[lambda_sg],
            role=lambda_role,
            environment={
                "SECRET_NAME": db.secret.secret_name if db.secret else "",
            },
        )

        api = apigateway.LambdaRestApi(
            self,
            "RmpApiGateway",
            handler=api_lambda,
            proxy=True,
        )

        # Outputs
        CfnOutput(self, "ApiEndpoint", value=api.url)
        CfnOutput(self, "DbEndpointAddress", value=db.db_instance_endpoint_address)
        if db.secret:
            CfnOutput(self, "DbSecretName", value=db.secret.secret_name)

        # Outputs to run the ECS one-off task manually
        CfnOutput(self, "PopulatorClusterName", value=cluster.cluster_name)
        CfnOutput(self, "PopulatorTaskDefinitionArn", value=populator_task.task_definition_arn)
        CfnOutput(self, "PopulatorSecurityGroupId", value=populator_sg.security_group_id)

