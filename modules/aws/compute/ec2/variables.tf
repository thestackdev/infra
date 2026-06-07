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

variable "subnet_id" {
  type        = string
  description = "Subnet to launch the instance into. Must belong to `vpc_id`."
}

variable "iam_instance_profile_name" {
  type        = string
  description = "IAM instance profile attached to the instance (for SSM Session Manager, etc.)."
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to the instance."
  default     = {}
}
