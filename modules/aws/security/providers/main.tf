locals {
  oidc_providers = {
    for k, v in var.oidc_providers : k => v
    if v.enabled
  }
}

resource "aws_iam_openid_connect_provider" "this" {
  for_each = local.oidc_providers

  url             = each.value.url
  client_id_list  = each.value.client_id_list
  thumbprint_list = each.value.thumbprint_list

  tags = merge(each.value.tags, var.tags)
}
