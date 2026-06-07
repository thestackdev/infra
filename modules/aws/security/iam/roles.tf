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
  for_each           = var.roles
  name               = "${var.name_prefix}-${each.key}"
  assume_role_policy = data.aws_iam_policy_document.assume_role[each.key].json
  tags               = var.tags
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
