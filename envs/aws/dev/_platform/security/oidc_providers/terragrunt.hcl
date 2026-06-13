include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "envcommon" {
  path   = "${dirname(find_in_parent_folders("root.hcl"))}/aws/_envcommon/security/oidc_providers.hcl"
  expose = true
}

inputs = {
  oidc_providers = {
    github = {
      enabled         = true
      url             = "https://token.actions.githubusercontent.com"
      client_id_list  = ["sts.amazonaws.com"]
      thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
    }
  }
}

