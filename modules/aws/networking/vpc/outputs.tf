output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "ID of the VPC."
}

output "public_subnets" {
  value       = module.vpc.public_subnets
  description = "Public subnet IDs, ordered by AZ."
}

output "private_subnets" {
  value       = module.vpc.private_subnets
  description = "Private subnet IDs, ordered by AZ."
}
