data "aws_ami" "ubuntu" {
  count       = var.enabled ? 1 : 0
  most_recent = true

  filter {
    name   = "name"
    values = [var.filter_name]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = [var.owners]
}

resource "aws_security_group" "this" {
  count       = var.enabled ? 1 : 0
  name_prefix = "${var.instance_name}-sg-"
  description = "${var.instance_name}-sg"
  vpc_id      = var.vpc_id

  tags = merge(var.tags, {
    Name = "${var.instance_name}-sg"
  })

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_vpc_security_group_egress_rule" "egress_rule" {
  count             = var.enabled ? 1 : 0
  security_group_id = aws_security_group.this[0].id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}

resource "aws_instance" "this" {
  count                       = var.enabled ? 1 : 0
  ami                         = data.aws_ami.ubuntu[0].id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  associate_public_ip_address = var.assign_public_ip
  iam_instance_profile        = var.iam_instance_profile_name
  vpc_security_group_ids      = [aws_security_group.this[0].id]
  monitoring                  = var.detailed_monitoring

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 2
    instance_metadata_tags      = "enabled"
  }

  root_block_device {
    volume_type           = var.root_volume_type
    volume_size           = var.root_volume_size
    encrypted             = true
    kms_key_id            = var.root_volume_kms_key_arn
    delete_on_termination = true

    tags = merge(var.tags, {
      Name = "${var.instance_name}-root"
    })
  }

  tags = merge(var.tags, {
    Name = var.instance_name
  })
}
