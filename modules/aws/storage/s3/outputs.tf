output "bucket_name" {
  value       = one(aws_s3_bucket.this[*].id)
  description = "The name of the S3 bucket."
}

output "bucket_arn" {
  value       = one(aws_s3_bucket.this[*].arn)
  description = "The ARN of the S3 bucket."
}

output "bucket_regional_domain_name" {
  value       = one(aws_s3_bucket.this[*].bucket_regional_domain_name)
  description = "The regional domain name of the S3 bucket, used as an origin for CloudFront."
}

output "website_domain" {
  value       = one(aws_s3_bucket_website_configuration.this[*].website_domain)
  description = "The domain of the S3 bucket website endpoint, used for Route 53 alias records."
}

output "website_endpoint" {
  value       = one(aws_s3_bucket_website_configuration.this[*].website_endpoint)
  description = "The website endpoint URL of the S3 bucket when configured for static website hosting."
}
