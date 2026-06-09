variable "enabled" {
  type        = bool
  description = "Flag to enable/disable"
  default     = false
}

variable "bucket_name" {
  type        = string
  description = "S3 bucket name."
}

variable "force_destroy" {
  type        = bool
  description = "Allow deletion when bucket is non-empty."
  default     = false
}

variable "versioning_enabled" {
  type        = bool
  description = "Enable object versioning."
  default     = true
}

variable "kms_key_arn" {
  type        = string
  description = "CMK ARN for SSE-KMS. Null uses SSE-S3."
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to the bucket."
  default     = {}
}
