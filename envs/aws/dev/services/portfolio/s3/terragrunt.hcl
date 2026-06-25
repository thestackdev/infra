locals {
  account = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  common  = read_terragrunt_config(find_in_parent_folders("common.hcl"))
}

include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "envcommon" {
  path   = "${dirname(find_in_parent_folders("root.hcl"))}/aws/_envcommon/storage/s3.hcl"
  expose = true
}

inputs = {
  enabled         = false
  bucket_name     = "${local.common.locals.project}-portfolio-${local.account.locals.env}"
  force_destroy   = true
  website_enabled = false
}
