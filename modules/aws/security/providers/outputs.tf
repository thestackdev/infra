output "provider_arns" {
  value       = { for k, v in aws_iam_openid_connect_provider.this : k => v.arn }
  description = "OIDC provider ARNs keyed by provider name."
}
