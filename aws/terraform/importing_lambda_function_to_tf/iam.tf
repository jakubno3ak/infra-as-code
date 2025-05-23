import {
  to = aws_iam_role.lambda_execution_role
  id = "manually-created-lambda-role-tms2l8qw"
}

import {
  to = aws_iam_policy.lambda_execution
  id = "arn:aws:iam::634993322111:policy/service-role/AWSLambdaBasicExecutionRole-11715130-2878-40a3-9a2e-258d699f7020"
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_iam_policy_document" "assume_lambda_execution_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "assume_lambda_execution" {
  statement {
    effect    = "Allow"
    resources = ["arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*"]
    actions   = ["logs:CreateLogGroup"]
  }

  statement {
    effect    = "Allow"
    resources = ["${aws_cloudwatch_log_group.lambda_log_group.arn}:*"]
    actions   = ["logs:CreateLogStream", "logs:PutLogEvents"]
  }
}

resource "aws_iam_policy" "lambda_execution" {
  name     = "AWSLambdaBasicExecutionRole-11715130-2878-40a3-9a2e-258d699f7020"
  path     = "/service-role/"
  policy   = data.aws_iam_policy_document.assume_lambda_execution.json
  tags     = {}
  tags_all = {}
}

resource "aws_iam_role" "lambda_execution_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_lambda_execution_role.json
  name               = "manually-created-lambda-role-tms2l8qw"
  path               = "/service-role/"
}

resource "aws_iam_role_policy_attachment" "lambda_execution" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = aws_iam_policy.lambda_execution.arn
}