output "instance_id" {
  value       = aws_instance.this.id
  description = "Instance ID."
}

output "arn" {
  value       = aws_instance.this.arn
  description = "Instance ARN."
}

output "public_ip" {
  value       = aws_instance.this.public_ip
  description = "Public IPv4."
}
