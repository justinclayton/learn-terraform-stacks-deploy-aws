# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

identity_token "aws" {
  audience = ["aws.workload.identity"]
}

store "varset" "aws_auth" {
  category = "terraform"
  name     = "hc-justin-clayton-varset"
}

deployment "development" {
  inputs = {
    regions        = ["us-east-2"]
    role_arn       = store.varset.aws_auth.stable.tfc_aws_run_role_arn
    identity_token = identity_token.aws.jwt
    default_tags = {
      Stack       = "learn-stacks-deploy-aws",
      Environment = "dev"
    }
  }
}

deployment "production" {
  inputs = {
    regions        = ["us-east-2", "us-west-2"]
    role_arn       = store.varset.aws_auth.stable.tfc_aws_run_role_arn
    identity_token = identity_token.aws.jwt
    default_tags = {
      Stack       = "learn-stacks-deploy-aws",
      Environment = "prod"
    }
  }
}
