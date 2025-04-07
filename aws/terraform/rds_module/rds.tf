module "rds" {
  source = "./modules/rds"

  project_name = "rds_module"

  credentials = {
    username = "db-admin"
    password = "db++1-?"
  }
}