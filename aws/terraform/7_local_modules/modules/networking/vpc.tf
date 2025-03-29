data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "this" {
  cidr_block = var.vpc_config.cidr_block

  tags = {
    Name = var.vpc_config.name
  }
}

resource "aws_subnet" "this" {
  for_each = var.subnet_config

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.az

  tags = {
    Name = each.key
  }

  lifecycle {
    precondition {
      condition     = contains(data.aws_availability_zones.available.names, each.value.az)
      error_message = <<-EOT
      The provided AZ: ${each.value.az} is invalid.
      [Subnet]: ${each.key}
      [AWS Region]: ${data.aws_availability_zones.available.id}
      [Invalid AZ]: ${each.value.az}
      [Available AZs]: [${join(", ", data.aws_availability_zones.available.names)}]
      EOT
    }
  }
}