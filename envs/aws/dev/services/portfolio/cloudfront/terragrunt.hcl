locals {
  account = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  common  = read_terragrunt_config(find_in_parent_folders("common.hcl"))
}

include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "envcommon" {
  path   = "${dirname(find_in_parent_folders("root.hcl"))}/aws/_envcommon/cdn/cloudfront.hcl"
  expose = true
}

dependency "s3_bucket" {
  config_path = "../s3"
}

inputs = {
  enabled                   = false
  regional_domain_name      = dependency.s3_bucket.outputs.bucket_regional_domain_name
  domain_name               = "shanmukeshwar.dev"
  subject_alternative_names = ["www.shanmukeshwar.dev"]
}
