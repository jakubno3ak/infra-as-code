locals {
  users_from_yaml = yamldecode(file("${path.module}/user-roles.yml"))
}

resource "aws_iam_user" "users" {
  for_each = toset(local.users_from_yaml.users[*].username)
  name     = each.value
}

output "users" {
  value = local.users_from_yaml
}