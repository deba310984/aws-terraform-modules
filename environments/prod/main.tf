# environments/prod — the SAME modules, sized for high availability:
# 3 AZs, one NAT Gateway per AZ (no single point of egress failure).

terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  # backend "s3" { ... }
}

provider "aws" {
  region = "ap-south-1"
  default_tags {
    tags = {
      Project     = "modules-demo"
      Environment = "prod"
      ManagedBy   = "Terraform"
    }
  }
}

module "vpc" {
  source = "../../modules/vpc"

  name       = "demo-prod"
  cidr_block = "10.20.0.0/16"
  azs        = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
  public_subnet_cidrs = [
    "10.20.0.0/24", "10.20.1.0/24", "10.20.2.0/24"
  ]
  private_subnet_cidrs = [
    "10.20.10.0/24", "10.20.11.0/24", "10.20.12.0/24"
  ]
  enable_nat_gateway = true
  single_nat_gateway = false # one NAT per AZ for HA

  tags = { Environment = "prod" }
}

output "vpc_id" {
  value = module.vpc.vpc_id
}
