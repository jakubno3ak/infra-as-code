data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Owner is Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

# I have created one manually in aws console just for this case :)
# we can filter all vpc in our provider region, in this case filtering by tags
data "aws_vpc" "console_managed" {
  tags = {
    Env = "Prod"
  }
}

data "aws_availability_zones" "aws_azs" {
  state = "available"
}

data "aws_iam_policy_document" "static_website" {
  statement {
    sid = "PublicReadGetObject"
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.public_read_bucket.arn}/*"]
  }
}

resource "aws_s3_bucket" "public_read_bucket" {
  bucket = "my-public-read-bucket"
}

output "ubuntu_ami_data" {
  value = data.aws_ami.ubuntu
}

output "aws_caller_identity" {
  value = data.aws_caller_identity.current
}

output "aws_region" {
  value = data.aws_region.current
}

output "prod_vpc_id" {
  value = data.aws_vpc.console_managed.id
}

output "azs" {
  value = data.aws_availability_zones.aws_azs.names
}

output "iam_policy"  {
  value = data.aws_iam_policy_document.static_website
}

resource "aws_instance" "web" {
  ami                         = data.aws_ami.ubuntu.id
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  # once it does not specified SG or subnets then TF will put this instance in one of the defaut ones created by AWS

  root_block_device {
    delete_on_termination = true
    volume_size           = 10
    volume_type           = "gp3"
  }
}

