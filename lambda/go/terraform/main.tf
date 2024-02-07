terraform {
  required_version = "~> 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.35.0"
    }
  }

   backend "s3" {
    bucket = "terraform-state-meaning-of-life"
    key    = "language-demo/lambda-go/terraform.tfstate"
    region = "us-east-2"
  }
}

provider "aws" {
  region = "us-east-2"
}

data "aws_caller_identity" "current" {}

# variable "env_name" {
#   description = "Environment name"
# }

data "local_file" "image_tag" {
  filename = "${path.module}/../version.txt"
}

locals {
  account_id      = data.aws_caller_identity.current.account_id
  lambda_role     = "language-demo-lambda"
  name            = "language-demo-go"
  timeout         = 5 # seconds
  region          = "us-east-2"
}



/*
* Lambda Function
*/

resource "aws_lambda_function" "language_demo_go" {
  function_name = "${local.name}"
  timeout       = "${local.timeout}"
  image_uri     = "${local.account_id}.dkr.ecr.${local.region}.amazonaws.com/${local.name}:${data.local_file.image_tag.content}"
  package_type  = "Image"
  role          = "arn:aws:iam::${local.account_id}:role/${local.lambda_role}"
  
  publish       = true // mark this as immutable

  environment {
    variables = {
#       ENVIRONMENT = var.env_name
      MEANING_OF_LIFE = "42"
    }
  }

  lifecycle {
    ignore_changes = [environment, image_uri]
  }
}

/*
* Lambda Aliases
*/
resource "aws_lambda_alias" "language_demo_go_dev" {
  name             = "dev"
  description      = "a sample description"
  function_name    = aws_lambda_function.language_demo_go.arn
  function_version = "1"

  lifecycle {
    ignore_changes = [function_version]
  }
}

resource "aws_lambda_alias" "language_demo_go_stage" {
  name             = "stage"
  description      = "a sample description"
  function_name    = aws_lambda_function.language_demo_go.arn
  function_version = "1"

  lifecycle {
    ignore_changes = [function_version]
  }
}

resource "aws_lambda_alias" "language_demo_go_companyx" {
  name             = "companyx"
  description      = "a sample description"
  function_name    = aws_lambda_function.language_demo_go.arn
  function_version = "1"

  lifecycle {
    ignore_changes = [function_version]
  }
}