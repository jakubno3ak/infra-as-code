terraform {
  required_version = ">=1.7.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}

resource "random_id" "bucket_suffix" {
  byte_length = 6
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-bucket-${random_id.bucket_suffix.hex}"
  tags = {
    Name = "my-bucket"
  }
}

output "bucket_name" {
  value = aws_s3_bucket.my_bucket.bucket
}

output "bucket_arn" {
  value = aws_s3_bucket.my_bucket.arn
}
