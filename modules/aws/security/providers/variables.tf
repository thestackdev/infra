variable "oidc_providers" {
  description = "Map of OIDC providers to create, keyed by a short name. Set enabled = false to skip a provider without removing it."
  type = map(object({
    enabled         = optional(bool, false)
    url             = string
    client_id_list  = list(string)
    thumbprint_list = list(string)
    tags            = optional(map(string), {})
  }))
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to resources."
  default     = {}
}
