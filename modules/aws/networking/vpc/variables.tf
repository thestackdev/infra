variable "enabled" {
  type        = bool
  description = "Flag to enable/disable"
  default     = false
}

variable "name" {
  type        = string
  description = "Name prefix for the VPC and its resources."
}

variable "cidr" {
  type        = string
  description = "Primary IPv4 CIDR for the VPC."
}

variable "max_azs" {
  type        = number
  description = "Upper bound on AZs to use."
  default     = 3

  validation {
    condition     = var.max_azs >= 1
    error_message = "max_azs must be at least 1."
  }
}

variable "enable_nat_gateway" {
  type        = bool
  description = "Provision NAT gateway(s)."
  default     = true
}

variable "single_nat_gateway" {
  type        = bool
  description = "Use one NAT gateway across AZs instead of one per AZ."
  default     = true
}

variable "map_public_ip_on_launch" {
  type        = bool
  description = "Auto-assign public IPv4 in public subnets."
  default     = false
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to all resources."
  default     = {}
}
