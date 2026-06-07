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
}

variable "private_subnets" {
  type        = list(string)
  description = "CIDR blocks for private subnets, one per AZ."
}

variable "public_subnets" {
  type        = list(string)
  description = "CIDR blocks for public subnets, one per AZ."
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to all resources."
}
