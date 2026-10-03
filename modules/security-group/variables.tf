# modules/security-group/variables.tf
# A reusable security group whose rules are driven entirely by input, so the
# same module builds an ALB SG, an app SG, a DB SG — just different rule lists.

variable "name" {
  description = "Name of the security group."
  type        = string
}

variable "description" {
  description = "Description of the security group."
  type        = string
  default     = "Managed by Terraform"
}

variable "vpc_id" {
  description = "VPC in which to create the security group."
  type        = string
}

variable "ingress_rules" {
  description = "Inbound rules. Each rule sets either cidr_blocks OR source_security_group_id."
  type = list(object({
    description              = optional(string, "")
    from_port                = number
    to_port                  = number
    protocol                 = optional(string, "tcp")
    cidr_blocks              = optional(list(string))
    source_security_group_id = optional(string)
  }))
  default = []
}

variable "egress_rules" {
  description = "Outbound rules. Defaults to allow-all when left empty."
  type = list(object({
    description              = optional(string, "")
    from_port                = number
    to_port                  = number
    protocol                 = optional(string, "tcp")
    cidr_blocks              = optional(list(string))
    source_security_group_id = optional(string)
  }))
  default = [{
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }]
}

variable "tags" {
  description = "Tags merged onto the security group."
  type        = map(string)
  default     = {}
}
