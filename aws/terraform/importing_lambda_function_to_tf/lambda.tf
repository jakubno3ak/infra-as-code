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
  role             = aws_iam_role.lambda_execution_role.arn
  runtime          = "python3.10"
  source_code_hash = data.archive_file.lambda_code.output_base64sha256

  tags = {
    "lambda-console:blueprint" = "hello-world-python"
  }

  logging_config {
    application_log_level = null
    log_format            = "Text"
    log_group             = aws_cloudwatch_log_group.lambda_log_group.name
  }
}

resource "aws_lambda_function_url" "this" {
  authorization_type = "AWS_IAM"
  function_name      = aws_lambda_function.this.function_name
}