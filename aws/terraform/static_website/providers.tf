terraform {
  required_version = "~> 1.0"
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

  backend "s3" {
    region = "eu-west-1"
    bucket = "terraform-remote-backend-iac"
    key    = "static_website/state.tfstate"
  }
}

provider "aws" {
  region = "eu-west-1"
}