import {
  to = aws_lambda_function.this
  id = "manually-created-lambda"
}

data "archive_file" "lambda_code" {
  type        = "zip"
  source_file = "${path.root}/build/lambda_function.py"
  output_path = "${path.root}/lambda.zip"
}

resource "aws_lambda_function" "this" {
  description      = "A starter AWS Lambda function."
  filename         = "lambda.zip"
  function_name    = "manually-created-lambda"
  handler          = "lambda_function.lambda_handler"
  role             = "arn:aws:iam::634993322111:role/service-role/manually-created-lambda-role-tms2l8qw" #aws_iam_role.lambda_execution_role.arn
  runtime          = "python3.10"
  source_code_hash = data.archive_file.lambda_code.output_base64sha256

  tags = {
    "lambda-console:blueprint" = "hello-world-python"
  }

  logging_config {
    application_log_level = null
    log_format            = "Text"
    log_group             = "/aws/lambda/manually-created-lambda"
  }
}