# modules/vpc/variables.tf — the module's INPUT interface.

variable "name" {
  description = "Name prefix applied to all VPC resources and tags."
  type        = string
}

variable "cidr_block" {
  description = "CIDR block for the VPC (e.g. 10.0.0.0/16)."
  type        = string
  default     = "10.0.0.0/16"
}

variable "azs" {
  description = "Availability Zones to spread subnets across (e.g. [\"ap-south-1a\",\"ap-south-1b\"])."
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for the public subnets, one per AZ."
  type        = list(string)

  validation {
    condition     = length(var.public_subnet_cidrs) > 0
    error_message = "Provide at least one public subnet CIDR."
  }
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for the private subnets, one per AZ."
  type        = list(string)
  default     = []
}

variable "enable_nat_gateway" {
  description = "Create NAT Gateway(s) so private subnets get outbound internet."
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "true = one shared NAT (cheaper); false = one NAT per AZ (HA)."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags merged onto every resource this module creates."
  type        = map(string)
  default     = {}
}
