# VPC Module

Creates a VPC with public and private subnets across multiple Availability
Zones, an Internet Gateway, and optional NAT Gateway(s).

## Usage
```hcl
module "vpc" {
  source = "../../modules/vpc"

  name                 = "demo"
  cidr_block           = "10.0.0.0/16"
  azs                  = ["ap-south-1a", "ap-south-1b"]
  public_subnet_cidrs  = ["10.0.0.0/24", "10.0.1.0/24"]
  private_subnet_cidrs = ["10.0.10.0/24", "10.0.11.0/24"]
  enable_nat_gateway   = true
  single_nat_gateway   = true

  tags = { Project = "demo", Environment = "dev" }
}
```

## Inputs
| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `name` | Name prefix for resources and tags | `string` | — | yes |
| `cidr_block` | VPC CIDR block | `string` | `"10.0.0.0/16"` | no |
| `azs` | Availability Zones for subnets | `list(string)` | — | yes |
| `public_subnet_cidrs` | Public subnet CIDRs (one per AZ) | `list(string)` | — | yes |
| `private_subnet_cidrs` | Private subnet CIDRs (one per AZ) | `list(string)` | `[]` | no |
| `enable_nat_gateway` | Create NAT for private egress | `bool` | `true` | no |
| `single_nat_gateway` | One shared NAT vs one per AZ | `bool` | `true` | no |
| `tags` | Tags merged onto all resources | `map(string)` | `{}` | no |

## Outputs
| Name | Description |
|------|-------------|
| `vpc_id` | ID of the VPC |
| `vpc_cidr_block` | CIDR block of the VPC |
| `public_subnet_ids` | IDs of the public subnets |
| `private_subnet_ids` | IDs of the private subnets |
| `nat_public_ips` | Public IP(s) of the NAT Gateway(s) |
| `internet_gateway_id` | ID of the Internet Gateway |
