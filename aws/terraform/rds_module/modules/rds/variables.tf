############################
# GENERAL INFORMATION
############################

variable "project_name" {
  type = string
}

############################
# DB CONFIGURATION
############################

variable "instance_class" {
  type    = string
  default = "db.t3.micro"

  validation {
    condition     = contains(["db.t3.micro"], var.instance_class)
    error_message = "Only db.t3.micro is allowed due to free tier access."
  }
}

variable "storage_size" {
  type    = number
  default = 10

  validation {
    condition     = var.storage_size >= 5 && var.storage_size <= 10
    error_message = "DB storage must be between 5 GBs and 10 GBs"
  }
}

variable "engine" {
  type    = string
  default = "postgres-latest"

  validation {
    condition     = contains(["postgres-latest", "postgres-16"], var.engine)
    error_message = "DB engine must be postgres-latest or postgres-16"
  }
}

############################
# DB CREDENTIALS
############################

variable "credentials" {
  type = object({
    username = string
    password = string
  })

  sensitive = true

  validation {
    condition = (
      length(regexall("[a-zA-Z]+", var.credentials.password)) > 0 &&
      length(regexall("[0-9]+", var.credentials.password)) > 0 &&
      length(regexall("^[a-zA-Z0-9+_?-]{6,}$", var.credentials.password)) > 0
    )
    error_message = <<-EOT
      Password must comply with the following format:

      1. Contain at least 1 character
      2. Contain at least 1 digit
      3. Be at least 6 characters long
      4. Contain only following characters: a-z, A-Z, 0-9, +, _, ?, -
      EOT
  }
}

############################
# DB NETWORK
############################

variable "subnet_ids" {
  type = list(string)
}

variable "security_group_ids" {
  type = list(string)
}

