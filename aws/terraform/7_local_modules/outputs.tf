output "module_vpc_id" {
  value = module.networking.vpc_id
}

output "module_public_subnets" {
  description = "The ID and the AZ of public subnets"
  value       = module.networking.public_subnets
}

output "module_private_subnets" {
  description = "The ID and the AZ of private subnets"
  value       = module.networking.private_subnets
}