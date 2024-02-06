terraform {
  required_version = "~> 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.46.0"
    }
  }

  backend "s3" {
    bucket = "terraform-state-meaning-of-life"
    key    = "language-demo/terraform.tfstate"
    region = "us-east-2"
  }
}

provider "aws" {
  region = "us-east-2"
}

data "aws_caller_identity" "current" {}

locals {
  account_id      = data.aws_caller_identity.current.account_id
  name            = "language-demo"
  region          = "us-east-2"
}

variable "repository_names" {
  description = "Names to create repos for"
  type        = list(string)
  default     = [
     "lambda-go",
     "lambda-scala",
     "lambda-rust"
    ]
}

/*
* IAM
*/

// Role
data "aws_iam_policy_document" "assume_role" {
  policy_id = "${local.name}-lambda"
  version   = "2012-10-17"
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda" {
  name                = "${local.name}-lambda"
  assume_role_policy  = data.aws_iam_policy_document.assume_role.json
}

/*
* Logs Policy
*/
data "aws_iam_policy_document" "logs" {
  policy_id = "${local.name}-lambda-logs"
  version   = "2012-10-17"
  statement {
    effect  = "Allow"
    actions = ["logs:CreateLogStream", "logs:PutLogEvents"]

    resources = [
      "arn:aws:logs:${local.region}:${local.account_id}:log-group:/aws/lambda/${local.name}*:*"
    ]
  }
}

resource "aws_iam_policy" "logs" {
  name   = "${local.name}-lambda-logs"
  policy = data.aws_iam_policy_document.logs.json
}

resource "aws_iam_role_policy_attachment" "logs" {
  depends_on  = [aws_iam_role.lambda, aws_iam_policy.logs]
  role        = aws_iam_role.lambda.name
  policy_arn  = aws_iam_policy.logs.arn
}

/*
* Cloudwatch Log Group
*/

resource "aws_cloudwatch_log_group" "log" {
  name              = "/aws/lambda/${local.name}"
  retention_in_days = 7
}

/*
* ECR Repositories
*/
resource "aws_ecr_repository" "ecr_repo" {
  for_each = toset(var.repository_names)
  name = each.value
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}