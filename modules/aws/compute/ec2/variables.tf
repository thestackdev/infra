variable "vpc_id" {
  type        = string
  description = "VPC ID."
}

variable "instance_name" {
  type        = string
  description = "Instance Name tag."
}

variable "filter_name" {
  type        = string
  description = "AMI name pattern."
}

variable "owners" {
  type        = string
  description = "AMI owner account ID."
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type."
}

variable "assign_public_ip" {
  type        = bool
  description = "Associate a public IP."
  default     = false
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID."
}

variable "iam_instance_profile_name" {
  type        = string
  description = "IAM instance profile name."
}

variable "root_volume_type" {
  type        = string
  description = "Root EBS volume type."
  default     = "gp3"
}

variable "root_volume_size" {
  type        = number
  description = "Root EBS volume size (GiB)."
  default     = 20
}

variable "root_volume_kms_key_arn" {
  type        = string
  description = "CMK ARN for root EBS. Null uses AWS-managed key."
  default     = null
}

variable "detailed_monitoring" {
  type        = bool
  description = "Enable detailed monitoring."
  default     = false
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to resources."
  default     = {}
}
