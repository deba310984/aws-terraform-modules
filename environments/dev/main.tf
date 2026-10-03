# environments/dev — the SAME modules, sized for a cheap dev environment:
# 2 AZs, a single shared NAT Gateway.

terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  # For real use, store state remotely (see repo docs):
  # backend "s3" { ... }
}

provider "aws" {
  region = "ap-south-1"
  default_tags {
    tags = {
      Project     = "modules-demo"
      Environment = "dev"
      ManagedBy   = "Terraform"
    }
  }
}

module "vpc" {
  source = "../../modules/vpc"

  name                 = "demo-dev"
  cidr_block           = "10.10.0.0/16"
  azs                  = ["ap-south-1a", "ap-south-1b"]
  public_subnet_cidrs  = ["10.10.0.0/24", "10.10.1.0/24"]
  private_subnet_cidrs = ["10.10.10.0/24", "10.10.11.0/24"]
  enable_nat_gateway   = true
  single_nat_gateway   = true # cheaper for dev

  tags = { Environment = "dev" }
}

output "vpc_id" {
  value = module.vpc.vpc_id
}
