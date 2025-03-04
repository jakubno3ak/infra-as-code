### Backends

1. Local: terraform state files are stored locally
2. Terraform Cloud: terraform state files are stored in Terraform Cloud
3. Terraform Third party remote backeds: e.g. S3, Azure Storage, GCS, etc.

### Terraform State Locking

- Terraform uses a lock file to prevent race conditions
- The lock file is a file that is used to lock the terraform state file
- Terraform configuration can provide only one backend
- Remote backends require authentication credentials in order for Terraform to properly access the files.
- When changes are made to the configured backend, we must rerun the terraform init
- We can migrate between different backends