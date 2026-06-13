output "id" {
  value       = one(aws_cloudfront_distribution.this[*].id)
  description = "FQDN of the distribution"
}

output "arn" {
  value       = one(aws_cloudfront_distribution.this[*].arn)
  description = "FQDN of the distribution"
}

output "domain_name" {
  value       = one(aws_cloudfront_distribution.this[*].domain_name)
  description = "FQDN of the distribution"
}
