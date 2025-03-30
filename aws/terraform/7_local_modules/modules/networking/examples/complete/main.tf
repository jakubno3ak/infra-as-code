module "networking" {
  source = "./modules/networking"

  vpc_config = {
    cidr_block = "10.0.0.0/16"
    name       = "name_of_the_vpc"
  }

  subnet_config = {
    subnet_1 = {
      cidr_block = "10.0.0.0/24"
      az         = "eu-west-1a"
    }

    subnet_2 = {
      cidr_block = "10.0.1.0/24"
      az         = "eu-west-1b"
      # Public subnets are indicated by setting the "public" option to true.
      public     = true
    }
  }
}