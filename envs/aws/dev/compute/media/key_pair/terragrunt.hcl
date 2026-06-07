locals {
  account = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  common  = read_terragrunt_config(find_in_parent_folders("common.hcl"))
}

include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "envcommon" {
  path   = "${dirname(find_in_parent_folders("root.hcl"))}/aws/_envcommon/compute/key_pair.hcl"
  expose = true
}

inputs = {
  key_name   = "public-key-${local.common.locals.project}-${local.account.locals.env}"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIECXQ5m9xwNK8K9cKfK+ShYy/6hXzZrBlSWTJDS/6xSn"
  tags       = local.common.locals.common_tags
}
