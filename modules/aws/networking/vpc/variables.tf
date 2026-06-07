variable "name" {
  type        = string
  description = "Name prefix applied to the VPC and its child resources."
}

variable "cidr" {
  type        = string
  description = "Primary IPv4 CIDR for the VPC, e.g. `10.0.0.0/16`."
}

variable "azs" {
  type        = list(string)
  description = "Availability Zones for subnets. Length must match `public_subnets` and `private_subnets`."

  validation {
    condition     = length(var.azs) > 0
    error_message = "At least one availability zone must be provided."
  }
}

variable "private_subnets" {
  type        = list(string)
  description = "CIDR blocks for private subnets, one per AZ."

  validation {
    condition     = length(var.private_subnets) == length(var.azs)
    error_message = "private_subnets length must match azs length."
  }
}

variable "public_subnets" {
  type        = list(string)
  description = "CIDR blocks for public subnets, one per AZ."

  validation {
    condition     = length(var.public_subnets) == length(var.azs)
    error_message = "public_subnets length must match azs length."
  }
}

variable "enable_nat_gateway" {
  type        = bool
  description = "Provision NAT gateway(s) so private subnets have egress to the internet."
  default     = true
}

variable "single_nat_gateway" {
  type        = bool
  description = "When true, use one NAT gateway shared across AZs (cheaper, single AZ failure domain). When false, one NAT per AZ (resilient)."
  default     = true
}

variable "map_public_ip_on_launch" {
  type        = bool
  description = "Auto-assign public IPv4 to instances launched in public subnets."
  default     = false
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to all resources."
  default     = {}
}
