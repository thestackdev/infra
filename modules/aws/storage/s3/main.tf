resource "aws_s3_bucket" "this" {
  count         = var.enabled ? 1 : 0
  bucket        = var.bucket_name
  force_destroy = var.force_destroy
  tags          = var.tags
}

resource "aws_s3_bucket_public_access_block" "this" {
  count  = var.enabled ? 1 : 0
  bucket = aws_s3_bucket.this[0].id

  block_public_acls       = !var.website_enabled
  block_public_policy     = !var.website_enabled
  ignore_public_acls      = !var.website_enabled
  restrict_public_buckets = !var.website_enabled
}

resource "aws_s3_bucket_ownership_controls" "this" {
  count  = var.enabled ? 1 : 0
  bucket = aws_s3_bucket.this[0].id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_versioning" "this" {
  count  = var.enabled ? 1 : 0
  bucket = aws_s3_bucket.this[0].id

  versioning_configuration {
    status = var.versioning_enabled ? "Enabled" : "Disabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  count  = var.enabled ? 1 : 0
  bucket = aws_s3_bucket.this[0].id

  rule {
    bucket_key_enabled = var.kms_key_arn != null
    apply_server_side_encryption_by_default {
      sse_algorithm     = var.kms_key_arn != null ? "aws:kms" : "AES256"
      kms_master_key_id = var.kms_key_arn
    }
  }
}

resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this[0].id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "arn:aws:s3:::${var.bucket_name}/*"
      },
    ]
  })
}

resource "aws_s3_bucket_website_configuration" "this" {
  count  = (var.enabled && var.website_enabled) ? 1 : 0
  bucket = aws_s3_bucket.this[0].id

  index_document {
    suffix = var.website_index_document
  }

  error_document {
    key = var.website_error_document
  }
}
