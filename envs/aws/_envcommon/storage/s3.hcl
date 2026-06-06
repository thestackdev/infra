locals {
  common = read_terragrunt_config(find_in_parent_folders("common.hcl"))
}

terraform {
  source = "${dirname(dirname(find_in_parent_folders("root.hcl")))}//modules/aws/storage/s3"
}

inputs = {
  tags = local.common.locals.common_tags
}
