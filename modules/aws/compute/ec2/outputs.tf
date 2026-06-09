output "instance_id" {
  value       = one(aws_instance.this[*].id)
  description = "Instance ID."
}

output "arn" {
  value       = one(aws_instance.this[*].arn)
  description = "Instance ARN."
}

output "public_ip" {
  value       = one(aws_instance.this[*].public_ip)
  description = "Public IPv4."
}
