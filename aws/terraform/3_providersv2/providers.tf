terraform {
    required_version = "~> 1.0"
    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
      }
    }
}

provider "aws" {
  region = "eu-west-1"
}

provider "aws" {
  region = "eu-central-1"
  alias = eu_central_1
}


resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-bucket-afdab234423"
  tags = {
    Name = "my-bucket"
  }
}

resource "aws_s3_bucket" "my_bucket_eu_central_1" {
  bucket = "my-bucket-afdab23442432432"
  # we need to specify the provider here
  provider = aws.eu_central_1
  tags = {
    Name = "my-bucket"
  }
}