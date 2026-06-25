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

