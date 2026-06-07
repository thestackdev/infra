locals {
  account = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  common  = read_terragrunt_config(find_in_parent_folders("common.hcl"))
}

include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "envcommon" {
  path   = "${dirname(find_in_parent_folders("root.hcl"))}/aws/_envcommon/networking/vpc.hcl"
  expose = true
}

inputs = {
  name                    = "${local.common.locals.project}-${local.account.locals.env}"
  cidr                    = "10.0.0.0/16"
  azs                     = ["${local.account.locals.aws_region}a", "${local.account.locals.aws_region}b", "${local.account.locals.aws_region}c"]
  private_subnets         = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets          = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  enable_nat_gateway      = true
  single_nat_gateway      = true
  map_public_ip_on_launch = true
}
