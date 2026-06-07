output "key_pair_id" {
  value       = aws_key_pair.this.id
  description = "ID of the key pair."
}

output "key_pair_arn" {
  value       = aws_key_pair.this.arn
  description = "ARN of the key pair."
}

output "key_name" {
  value       = aws_key_pair.this.key_name
  description = "Name of the key pair."
}
