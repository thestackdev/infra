variable "vpc_id" {
  type        = string
  description = "VPC the instance attaches to."
}

variable "instance_name" {
  type        = string
  description = "Value of the Name tag on the instance."
}

variable "filter_name" {
  type        = string
  description = "AMI name pattern for the `aws_ami` lookup."
}

variable "owners" {
  type        = string
  description = "AMI owner account ID (e.g. `099720109477` for Canonical)."
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type, e.g. `t3.small`."
}

variable "assign_public_ip" {
  type        = bool
  description = "Boolean flag to associate public ip address"
  default     = false
}

variable "subnet_id" {
  type        = string
  description = "Subnet to launch the instance into. Must belong to `vpc_id`."
}

variable "iam_instance_profile_name" {
  type        = string
  description = "IAM instance profile attached to the instance (for SSM Session Manager, etc.)."
}

variable "root_volume_type" {
  type        = string
  description = "EBS volume type for the root device (gp3 recommended)."
  default     = "gp3"
}

variable "root_volume_size" {
  type        = number
  description = "Root EBS volume size in GiB."
  default     = 20
}

variable "root_volume_kms_key_arn" {
  type        = string
  description = "Optional CMK ARN for root EBS encryption. When null, uses the AWS-managed `aws/ebs` key."
  default     = null
}

variable "detailed_monitoring" {
  type        = bool
  description = "Enable EC2 detailed (1-minute) CloudWatch monitoring."
  default     = false
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to the instance."
  default     = {}
}
