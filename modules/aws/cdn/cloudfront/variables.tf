variable "enabled" {
  type        = bool
  description = "Enable this service"
  default     = false
}

variable "regional_domain_name" {
  type        = string
  description = "S3 bucket regional domain name for the CloudFront origin"
}

variable "domain_name" {
  type        = string
  description = "Primary domain name for the ACM certificate and CloudFront alias"
}

variable "subject_alternative_names" {
  type        = list(string)
  description = "Additional domain names to include in the ACM certificate and CloudFront aliases"
  default     = []
}

variable "default_root_object" {
  type        = string
  description = "Object CloudFront returns when the root URL is requested"
  default     = "index.html"
}

variable "oac_name" {
  type        = string
  description = "Name for the CloudFront origin access control"
  default     = "CloudFront S3 OAC"
}

