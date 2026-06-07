output "instance_id" {
  value       = aws_instance.this.id
  description = "ID of the EC2 instance."
}

output "arn" {
  value       = aws_instance.this.arn
  description = "ARN of the EC2 instance."
}

output "public_ip" {
  value       = aws_instance.this.public_ip
  description = "Public IPv4 of the instance, if assigned."
}
