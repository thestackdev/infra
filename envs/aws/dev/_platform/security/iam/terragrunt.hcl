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
      enabled                 = false
      principal_type          = "Service"
      principal_identifiers   = ["ec2.amazonaws.com"]
      managed_policy_arns     = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]
      create_instance_profile = true
    }
    github_actions = {
      enabled               = true
      principal_type        = "Federated"
      principal_identifiers = ["arn:aws:iam::949530157299:oidc-provider/token.actions.githubusercontent.com"]
      sts_action            = "sts:AssumeRoleWithWebIdentity"
      conditions = [
        {
          test     = "StringEquals"
          variable = "token.actions.githubusercontent.com:aud"
          values   = ["sts.amazonaws.com"]
        },
        {
          test     = "StringLike"
          variable = "token.actions.githubusercontent.com:sub"
          values   = ["repo:thestackdev/portfolio:*"]
        }
      ]
      managed_policy_arns = []
      inline_policies = {
        s3_portfolio = jsonencode({
          Version = "2012-10-17"
          Statement = [
            {
              Effect   = "Allow"
              Action   = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"]
              Resource = "arn:aws:s3:::thestackdev-portfolio-dev/*"
            },
            {
              Effect   = "Allow"
              Action   = ["s3:ListBucket"]
              Resource = "arn:aws:s3:::thestackdev-portfolio-dev"
            }
          ]
        })
      }
      create_instance_profile = false
    }
  }
}
