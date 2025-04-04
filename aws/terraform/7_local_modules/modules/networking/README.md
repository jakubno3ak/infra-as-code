### VPC module

It allows to create vpc and private/public subnets easily.

Example:

```hcl
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
      public     = true
    }
  }
}
```

### Inspired by:
https://www.udemy.com/course/mastering-terraform-beginner-to-expert/