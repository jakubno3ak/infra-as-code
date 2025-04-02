import {
  to = aws_iam_role.lambda_execution_role
  id = "manually-created-lambda-role-cj5sxk6d"
}

resource "aws_iam_role" "lambda_execution_role" {
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })

  name = "manually-created-lambda-role-cj5sxk6d"
  path = "/service-role/"
}
