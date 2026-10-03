# Security Group Module

A reusable security group whose inbound/outbound rules are passed as input, so
one module definition builds any tier's SG (ALB, app, database, …).

## Usage
```hcl
module "app_sg" {
  source = "../../modules/security-group"

  name   = "demo-app"
  vpc_id = module.vpc.vpc_id

  ingress_rules = [{
    description              = "App port from the ALB only"
    from_port                = 80
    to_port                  = 80
    source_security_group_id = module.alb_sg.security_group_id
  }]

  tags = { Project = "demo" }
}
```

## Inputs
| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `name` | Security group name | `string` | — | yes |
| `description` | Security group description | `string` | `"Managed by Terraform"` | no |
| `vpc_id` | VPC to create the SG in | `string` | — | yes |
| `ingress_rules` | Inbound rules (cidr_blocks OR source_security_group_id) | `list(object)` | `[]` | no |
| `egress_rules` | Outbound rules | `list(object)` | allow-all | no |
| `tags` | Tags merged onto the SG | `map(string)` | `{}` | no |

Each rule object: `{ description, from_port, to_port, protocol, cidr_blocks, source_security_group_id }`.

## Outputs
| Name | Description |
|------|-------------|
| `security_group_id` | ID of the security group |
| `security_group_arn` | ARN of the security group |
