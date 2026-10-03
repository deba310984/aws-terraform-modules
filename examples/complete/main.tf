# examples/complete/main.tf
# Wires the reusable modules together into a working two-tier network:
# VPC -> ALB SG (open to internet) -> App SG (open only to the ALB SG).

locals {
  tags = {
    Project     = var.name
    Environment = "example"
  }
}

module "vpc" {
  source = "../../modules/vpc"

  name                 = var.name
  cidr_block           = var.vpc_cidr
  azs                  = var.azs
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  enable_nat_gateway   = true
  single_nat_gateway   = true

  tags = local.tags
}

module "alb_sg" {
  source = "../../modules/security-group"

  name   = "${var.name}-alb"
  vpc_id = module.vpc.vpc_id

  ingress_rules = [{
    description = "HTTP from the internet"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }]

  tags = local.tags
}

module "app_sg" {
  source = "../../modules/security-group"

  name   = "${var.name}-app"
  vpc_id = module.vpc.vpc_id

  # Trust the ALB tier by security-group reference, not by IP.
  ingress_rules = [{
    description              = "App port from the ALB security group only"
    from_port                = 80
    to_port                  = 80
    source_security_group_id = module.alb_sg.security_group_id
  }]

  tags = local.tags
}
