locals {
  account = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  common  = read_terragrunt_config(find_in_parent_folders("common.hcl"))
}

terraform {
  source = "${dirname(dirname(find_in_parent_folders("root.hcl")))}//modules/aws/security/iam"
}

inputs = {
  name_prefix = "${local.common.locals.project}-${local.account.locals.env}"
  tags        = local.common.locals.common_tags
}
