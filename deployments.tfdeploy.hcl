# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

identity_token "aws" {
  audience = ["aws.workload.identity"]
}

store "varset" "aws_auth" {
  category = "env"
  name     = "hc-justin-clayton-varset"
}

deployment "development" {
  destroy = true
  inputs = {
    regions        = ["us-east-2"]
    role_arn       = store.varset.aws_auth.stable.TFC_AWS_RUN_ROLE_ARN
    identity_token = identity_token.aws.jwt
    default_tags = {
      Stack       = "learn-stacks-deploy-aws",
      Environment = "dev"
    }
  }
}

deployment "production" {
  destroy = true
  inputs = {
    regions        = ["us-east-2", "us-west-2"]
    role_arn       = store.varset.aws_auth.stable.TFC_AWS_RUN_ROLE_ARN
    identity_token = identity_token.aws.jwt
    default_tags = {
      Stack       = "learn-stacks-deploy-aws",
      Environment = "prod"
    }
  }
}
