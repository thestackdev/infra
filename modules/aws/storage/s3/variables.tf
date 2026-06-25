variable "enabled" {
  type        = bool
  description = "Flag to enable or disable creation of the S3 bucket and associated resources."
  default     = false
}

variable "bucket_name" {
  type        = string
  description = "Globally unique name of the S3 bucket."
}

variable "force_destroy" {
  type        = bool
  description = "Allow the bucket to be destroyed even when it contains objects. Use with caution."
  default     = false
}

variable "versioning_enabled" {
  type        = bool
  description = "Enable versioning to keep multiple variants of objects in the bucket."
  default     = true
}

variable "kms_key_arn" {
  type        = string
  description = "ARN of a KMS CMK for SSE-KMS encryption. If null, SSE-S3 managed encryption is used."
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Map of tags to apply to the bucket and all associated resources."
  default     = {}
}
