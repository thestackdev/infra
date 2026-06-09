include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "envcommon" {
  path   = "${dirname(find_in_parent_folders("root.hcl"))}/aws/_envcommon/security/iam.hcl"
  expose = true
}

dependency "media_bucket" {
  config_path = "${dirname(find_in_parent_folders("account.hcl"))}/services/media/s3"
}

inputs = {
  roles = {
    ssm = {
      trusted_services    = ["ec2.amazonaws.com"]
      managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]
      inline_policies = {
        media_s3_read = jsonencode({
          Version = "2012-10-17"
          Statement = [{
            Effect = "Allow"
            Action = ["s3:GetObject", "s3:ListBucket"]
            Resource = [
              dependency.media_bucket.outputs.bucket_arn,
              "${dependency.media_bucket.outputs.bucket_arn}/*",
            ]
          }]
        })
      }
      create_instance_profile = true
    }
  }
}
