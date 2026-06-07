locals {
  account = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  common  = read_terragrunt_config(find_in_parent_folders("common.hcl"))
}

include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "envcommon" {
  path   = "${dirname(find_in_parent_folders("root.hcl"))}/aws/_envcommon/security/iam.hcl"
  expose = true
}

inputs = {
  name_prefix = "${local.common.locals.project}-${local.account.locals.env}"
  roles = {
    ssm = {
      trusted_services        = ["ec2.amazonaws.com"]
      managed_policy_arns     = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]
      create_instance_profile = true
    }
  }
}
