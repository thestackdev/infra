variable "roles" {
  type = map(object({
    trusted_services        = list(string)
    managed_policy_arns     = list(string)
    create_instance_profile = optional(bool, false)
  }))
  description = "Map of roles to create, keyed by short name."
}

variable "name_prefix" {
  type        = string
  description = "Prefix for every role/profile name."
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to all IAM resources."
  default     = {}
}

