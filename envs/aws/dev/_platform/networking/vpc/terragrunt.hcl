include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "envcommon" {
  path   = "${dirname(find_in_parent_folders("root.hcl"))}/aws/_envcommon/networking/vpc.hcl"
  expose = true
}

inputs = {
  enabled                 = false
  cidr                    = "10.0.0.0/16"
  enable_nat_gateway      = true
  single_nat_gateway      = true
  map_public_ip_on_launch = true
}
