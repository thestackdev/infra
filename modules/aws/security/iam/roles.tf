data "aws_iam_policy_document" "assume_role" {
  for_each = var.roles
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = each.value.trusted_services
    }
  }
}

resource "aws_iam_role" "this" {
  for_each = var.roles

  name               = "${var.name_prefix}-${each.key}"
  assume_role_policy = data.aws_iam_policy_document.assume_role[each.key].json
  tags               = var.tags
}

resource "aws_iam_role_policy" "inline" {
  for_each = {
    for pair in flatten([
      for role_key, role in var.roles : [
        for pname, pjson in role.inline_policies : {
          role_key = role_key
          pname    = pname
          pjson    = pjson
        }
      ]
    ]) : "${pair.role_key}::${pair.pname}" => pair
  }

  name   = "${var.name_prefix}-${each.value.role_key}-${each.value.pname}"
  role   = aws_iam_role.this[each.value.role_key].name
  policy = each.value.pjson
}

resource "aws_iam_instance_profile" "this" {
  for_each = {
    for k, v in var.roles : k => v
    if v.create_instance_profile
  }
  name = "${var.name_prefix}-${each.key}"
  role = aws_iam_role.this[each.key].name
  tags = var.tags
}
