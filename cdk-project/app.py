#!/usr/bin/env python3
"""
CDK app entrypoint.

The CDK CLI runs this file (configured via `cdk.json`) to synthesize the
CloudFormation template for this project.
"""
import os

import aws_cdk as cdk

from cdk_project.cdk_project_stack import CdkProjectStack


app = cdk.App()
# Instantiate the stack. Account/region default from your AWS CLI environment.
CdkProjectStack(
    app,
    "CdkProjectStack",
    env=cdk.Environment(
        account=os.getenv("CDK_DEFAULT_ACCOUNT"),
        region=os.getenv("CDK_DEFAULT_REGION"),
    ),
)
# Emit CloudFormation templates into `cdk.out/`.
app.synth()

