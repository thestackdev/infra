locals {
  account = read_terragrunt_config(find_in_parent_folders("account.hcl"))
}

include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "envcommon" {
  path   = "${dirname(find_in_parent_folders("root.hcl"))}/aws/_envcommon/storage/s3.hcl"
  expose = true
}

inputs = {
  bucket_name = "thestackdev-media-${local.account.locals.env}"
}
