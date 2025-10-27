from aws_cdk import (
    App,
    aws_lambda as lambda_,
    aws_apigateway as apigateway,
    aws_ecr as ecr,
    aws_iam as iam,
    aws_ec2 as ec2,
    Duration,
    Stack,
    aws_sqs as sqs,
    CfnOutput,
    Environment
)
from constructs import Construct

class CdkProjectStack(Stack):

    def __init__(self, scope: Construct, construct_id: str, **kwargs) -> None:
        super().__init__(scope, construct_id, **kwargs)
        
        #vpc
        my_vpc = ec2.Vpc.from_lookup(self, "MyVpc", vpc_id = "vpc-098086a22edb3ded2")
        
        # Create a security group for Lambda to allow outbound access (to RDS)
        lambda_security_group = ec2.SecurityGroup(self, "LambdaSG",
            vpc=my_vpc,
            allow_all_outbound=True  # Allows Lambda to communicate with RDS
        )   
         
        # Reference your ECR repository
        repository = ecr.Repository.from_repository_name(self, "ECRRepo", "my-repo")
        
        # Lambda Execution Role
        lambda_role = iam.Role(self, "LambdaExecutionRole",
            assumed_by=iam.ServicePrincipal("lambda.amazonaws.com"),
            managed_policies=[
                iam.ManagedPolicy.from_aws_managed_policy_name("service-role/AWSLambdaVPCAccessExecutionRole")
            ]
        )

        # Add Secrets Manager permissions for Lambda
        lambda_role.add_to_policy(
        iam.PolicyStatement(
            actions=["secretsmanager:GetSecretValue"],
            resources=["arn:aws:secretsmanager:us-west-2:767828744487:secret:rmp-db/secrets-*"]
        ))
 
        # Create Lambda function using the Docker image
        lambda_function = lambda_.Function(
            self,
            id = "MyLambdaFunction",
            code=lambda_.Code.from_ecr_image(repository),
            handler=lambda_.Handler.FROM_IMAGE,
            runtime=lambda_.Runtime.FROM_IMAGE,
            timeout= Duration.seconds(300),
            memory_size=512,
            vpc=my_vpc,  # Attach the Lambda to your VPC
            vpc_subnets={"subnet_type": ec2.SubnetType.PRIVATE_ISOLATED },  # Use private subnet
            security_groups=[lambda_security_group],  # Assign security group
            role=lambda_role
        )
        
        # Get the default security group of the VPC
        default_security_group = ec2.SecurityGroup.from_security_group_id(self, "DefaultSecurityGroup", "sg-0f71cae00a9e471d8")

        default_security_group.add_ingress_rule(
            peer=lambda_security_group, 
            connection=ec2.Port.tcp(5432),  # PostgreSQL port
            description="Allow Lambda access to RDS"
        )
        
        
        # Create API Gateway
        api = apigateway.LambdaRestApi(
            self, "RmpApiGateway",
            handler=lambda_function,
            proxy=True
        )

        # Output the API Gateway endpoint
        CfnOutput(self, "ApiEndpoint", value=api.url)


