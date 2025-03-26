data "aws_availability_zones" "azs" {
  state = "available"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.5.3"

  name = "public-modules"

  cidr            = "10.0.0.0/16"
  private_subnets = ["10.0.0.0/24"]
  public_subnets  = ["10.0.128.0/24"]

  azs = data.aws_availability_zones.azs.names
}

provider "aws" {
  region = "eu-west-1"
}
