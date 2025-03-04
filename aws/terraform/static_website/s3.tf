resource "random_id" "bucket_suffix" {
  byte_length = 4
}


resource "aws_s3_bucket" "static-website" {
  bucket = "static-website-${random_id.bucket_suffix.hex}"
  tags = {
    Name = "static-website"
  }
}

resource "aws_s3_bucket_public_access_block" "static-website" {
  bucket                  = aws_s3_bucket.static-website.bucket
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "static-website" {
  bucket = aws_s3_bucket.static-website.bucket
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.static-website.arn}/*"
      }
    ]
  })

  depends_on = [aws_s3_bucket.static-website, aws_s3_bucket_public_access_block.static-website]
}

resource "aws_s3_bucket_website_configuration" "static-website" {
  bucket = aws_s3_bucket.static-website.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

locals {
  html_files = {
    "index.html" = "text/html"
    "error.html" = "text/html"
  }
}

resource "aws_s3_object" "html_files" {
  count        = length(local.html_files)
  bucket       = aws_s3_bucket.static-website.bucket
  key          = keys(local.html_files)[count.index]
  source       = "${path.module}/build/${keys(local.html_files)[count.index]}"
  etag         = filemd5("${path.module}/build/${keys(local.html_files)[count.index]}")
  content_type = values(local.html_files)[count.index]
}

