variable "region" {
  description = "AWS region."
  type        = string
  default     = "ap-south-1"
}

variable "name" {
  description = "Name prefix for all resources."
  type        = string
  default     = "modules-demo"
}

variable "azs" {
  description = "Availability Zones."
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b"]
}

variable "vpc_cidr" {
  description = "VPC CIDR block."
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDRs."
  type        = list(string)
  default     = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "private_subnet_cidrs" {
  description = "Private subnet CIDRs."
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.11.0/24"]
}
