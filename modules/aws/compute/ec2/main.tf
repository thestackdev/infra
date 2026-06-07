data "aws_ami" "ubuntu" {
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
  name        = "${var.instance_name}-sg"
  description = "Egress only — SSM Agent outbound to AWS endpoints"
  vpc_id      = var.vpc_id

  tags = merge(var.tags, {
    Name = "${var.instance_name}-sg"
  })
}

resource "aws_vpc_security_group_egress_rule" "egress_rule" {
  security_group_id = aws_security_group.this.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}

resource "aws_instance" "this" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  iam_instance_profile   = var.iam_instance_profile_name
  vpc_security_group_ids = [aws_security_group.this.id]
  tags = merge(var.tags, {
    Name = var.instance_name
  })
}
