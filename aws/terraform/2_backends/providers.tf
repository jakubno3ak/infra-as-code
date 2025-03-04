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

  backend "s3" {
    region = "eu-west-1"
    bucket = "terraform-remote-backend-iac"
    key    = "2_backends/state.tfstate"
    # if we would like to support locking, we need to provide a dynamodb table name, this might be helpful if we have multiple teams working on the same infrastructure
    # this is a good practice to avoid race conditions. The terraform will look if the lock is already taken and if it is, it will return an error untill the lock is released.
    # dynamodb_table = "terraform-lock"
  }
}

provider "aws" {
  region = "eu-west-1"
}