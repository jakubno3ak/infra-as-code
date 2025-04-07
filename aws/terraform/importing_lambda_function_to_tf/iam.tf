import {
  to = aws_iam_role.lambda_execution_role
  id = "manually-created-lambda-role-tms2l8qw"
}

import {
  to = aws_iam_policy.lambda_execution
  id = "arn:aws:iam::634993322111:policy/service-role/AWSLambdaBasicExecutionRole-11715130-2878-40a3-9a2e-258d699f7020"
}

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

resource "aws_iam_policy" "lambda_execution" {
  name = "AWSLambdaBasicExecutionRole-11715130-2878-40a3-9a2e-258d699f7020"
  path = "/service-role/"
  policy = jsonencode({
    Statement = [{
      Action   = "logs:CreateLogGroup"
      Effect   = "Allow"
      Resource = "arn:aws:logs:eu-central-1:634993322111:*"
      }, {
      Action   = ["logs:CreateLogStream", "logs:PutLogEvents"]
      Effect   = "Allow"
      Resource = ["arn:aws:logs:eu-central-1:634993322111:log-group:/aws/lambda/manually-created-lambda:*"]
    }]
    Version = "2012-10-17"
  })
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