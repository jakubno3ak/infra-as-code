import {
  to = aws_cloudwatch_log_group.lambda_log_group
  id = "/aws/lambda/manually-created-lambda"
}

resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name = "/aws/lambda/manually-created-lambda"
}
