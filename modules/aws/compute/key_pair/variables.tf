variable "key_name" {
  type        = string
  description = "Name of the EC2 key pair."
}

variable "public_key" {
  type        = string
  description = "OpenSSH-format public key material."
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to the key pair."
  default     = {}
}
