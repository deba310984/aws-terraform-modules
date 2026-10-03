output "vpc_id" {
  description = "ID of the created VPC."
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "Public subnet IDs."
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Private subnet IDs."
  value       = module.vpc.private_subnet_ids
}

output "nat_public_ips" {
  description = "NAT Gateway public IP(s)."
  value       = module.vpc.nat_public_ips
}

output "alb_security_group_id" {
  description = "ALB security group ID."
  value       = module.alb_sg.security_group_id
}

output "app_security_group_id" {
  description = "App security group ID."
  value       = module.app_sg.security_group_id
}
