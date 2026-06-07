output "bucket_name" {
  value       = aws_s3_bucket.this.id
  description = "Name of the bucket."
}

output "bucket_arn" {
  value       = aws_s3_bucket.this.arn
  description = "ARN of the bucket."
}
