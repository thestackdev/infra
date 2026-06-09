locals {
  account = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  common  = read_terragrunt_config(find_in_parent_folders("common.hcl"))
}

include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "envcommon" {
  path   = "${dirname(find_in_parent_folders("root.hcl"))}/aws/_envcommon/compute/ec2.hcl"
  expose = true
}

dependency "vpc" {
  config_path = "../../../_platform/networking/vpc"
}

dependency "iam" {
  config_path = "../../../_platform/security/iam"
}


inputs = {
  enabled                   = false
  vpc_id                    = dependency.vpc.outputs.vpc_id
  subnet_id                 = dependency.vpc.outputs.public_subnets[0]
  iam_instance_profile_name = dependency.iam.outputs.instance_profile_names["ssm"]
  instance_name             = "${local.common.locals.project}-vpn-${local.account.locals.env}"
  filter_name               = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
  instance_type             = "t3.micro"
  assign_public_ip          = true
  owners                    = "099720109477"
}
