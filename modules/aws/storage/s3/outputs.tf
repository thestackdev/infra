output "bucket_name" {
  value       = one(aws_s3_bucket.this[*].id)
  description = "Bucket name."
}

output "bucket_arn" {
  value       = one(aws_s3_bucket.this[*].arn)
  description = "Bucket ARN."
}
