locals {
  project_name = "public_modules"
  shared_tags = {
    Project   = local.project_name
    ManagedBy = "terraform"
  }
}