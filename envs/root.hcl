locals {
  common  = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  account = read_terragrunt_config(find_in_parent_folders("account.hcl"))
}


remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket         = "${local.common.locals.project}-terragrunt-state-${local.account.locals.env}"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.account.locals.aws_region
    profile        = local.account.locals.profile
    encrypt        = true
    dynamodb_table = "tf-locks"
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "aws" {
  region              = "${local.account.locals.aws_region}"
  profile             = "${local.account.locals.profile}"
  allowed_account_ids = ["${local.account.locals.aws_account_id}"]
}

provider "aws" {
  alias               = "us_east_1"
  region              = "us-east-1"
  profile             = "${local.account.locals.profile}"
  allowed_account_ids = ["${local.account.locals.aws_account_id}"]
}
EOF
}
