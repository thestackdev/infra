include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "envcommon" {
  path   = "${dirname(find_in_parent_folders("root.hcl"))}/aws/_envcommon/security/iam.hcl"
  expose = true
}

inputs = {
  roles = {
    ssm = {
      trusted_services        = ["ec2.amazonaws.com"]
      managed_policy_arns     = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]
      create_instance_profile = true
    }
  }
}
