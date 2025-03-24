locals {
  role_policies = {
    readonly = [
      "ReadOnlyAccess"
    ]
    admin = [
      "AdministratorAccess"
    ],
    auditor = [
      "SecurityAudit"
    ]
    developer = [
      "AmazonVPCFullAccess",
      "AmazonEC2FullAccess",
      "AmazonRDSFullAccess"
    ]
  }
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = [""]
    }
  }
}

resource "aws_iam_role" "roles" {
  for_each = toset(keys(local.role_policies))
  name     = each.key

  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}