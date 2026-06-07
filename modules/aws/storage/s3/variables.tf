variable "bucket_name" {
  type        = string
  description = "Globally unique S3 bucket name."
}

variable "force_destroy" {
  type        = bool
  description = "Allow Terraform to delete the bucket even when it contains objects. Keep false for any data you don't want silently wiped."
  default     = false
}

variable "versioning_enabled" {
  type        = bool
  description = "Enable S3 object versioning. Required for MFA delete, replication, and most recovery workflows."
  default     = true
}

variable "kms_key_arn" {
  type        = string
  description = "Optional CMK ARN for SSE-KMS. When null, the bucket uses SSE-S3 (AES256) with AWS-managed keys."
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to the bucket."
  default     = {}
}
