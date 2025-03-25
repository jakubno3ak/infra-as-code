locals {
  users_from_yaml = yamldecode(file("${path.module}/user-roles.yml"))
  users_map = {
    for user_config in local.users_from_yaml.users : user_config.username => user_config.roles
  }
}

resource "aws_iam_user" "users" {
  for_each = toset(local.users_from_yaml.users[*].username)
  name     = each.value
}

resource "aws_iam_user_login_profile" "users" {
  for_each        = aws_iam_user.users
  user            = each.value.name
  password_length = 8

  lifecycle {
    # ENSURES THAT ANY CHANGES HERE WILL NOT IMPACT EXISTING USERS
    ignore_changes = [
      password_length,
      password_reset_required,
      pgp_key
    ]
  }
}

output "users" {
  value = local.users_from_yaml
}