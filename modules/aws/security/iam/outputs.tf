output "role_arns" {
  value       = { for k, v in aws_iam_role.this : k => v.arn }
  description = "Role ARNs by name."
}

output "role_names" {
  value       = { for k, v in aws_iam_role.this : k => v.name }
  description = "Role names by name."
}

output "instance_profile_names" {
  value       = { for k, v in aws_iam_instance_profile.this : k => v.name }
  description = "Instance profile names by role name."
}
