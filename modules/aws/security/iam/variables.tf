variable "roles" {
  type = map(object({
    trusted_services        = list(string)
    managed_policy_arns     = list(string)
    inline_policies         = optional(map(string), {})
    create_instance_profile = optional(bool, false)
  }))
  description = "Roles to create, keyed by short name."
}

variable "name_prefix" {
  type        = string
  description = "Prefix for role/profile names."
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to resources."
  default     = {}
}
