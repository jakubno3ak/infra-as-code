locals {
  vpc_cidr              = "10.0.0.0/16"
  public_subnet_cidrs   = ["10.0.128.0/24"]
  private_subnets_cidrs = ["10.0.0.0/24"]
}

data "aws_availability_zones" "azs" {
  state = "available"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.5.3"

  name = local.project_name

  cidr            = local.vpc_cidr
  public_subnets  = local.public_subnet_cidrs
  private_subnets = local.private_subnets_cidrs

  azs = data.aws_availability_zones.azs.names

  tags = merge(local.shared_tags, { MergedTag = "merged_tag" })
}

provider "aws" {
  region = "eu-west-1"
}
