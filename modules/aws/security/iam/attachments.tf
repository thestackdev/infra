locals {
  role_policy_pairs = flatten([
    for role_key, role in var.roles : [
      for policy_arn in role.managed_policy_arns : {
        role_key   = role_key
        policy_arn = policy_arn
      }
    ]
  ])
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each = {
    for pair in local.role_policy_pairs :
    "${pair.role_key}::${pair.policy_arn}" => pair
  }
  role       = aws_iam_role.this[each.value.role_key].name
  policy_arn = each.value.policy_arn
}
