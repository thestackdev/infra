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
  config_path = "../../../networking/vpc"
}

dependency "key_pair" {
  config_path = "../key_pair"
}


inputs = {
  vpc_id        = dependency.vpc.outputs.vpc_id
  subnet_id     = dependency.vpc.outputs.public_subnets[0]
  instance_name = "media-${local.account.locals.env}"
  filter_name   = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
  instance_type = "t2.micro"
  owners        = "099720109477"
  key_name      = dependency.key_pair.outputs.key_name
}
