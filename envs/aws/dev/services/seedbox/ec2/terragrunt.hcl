locals {
  account = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  common  = read_terragrunt_config(find_in_parent_folders("common.hcl"))
}

include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "envcommon" {
  path   = "${dirname(find_in_parent_folders("root.hcl"))}/aws/_envcommon/compute/ec2.hcl"
  expose = true
}

dependency "vpc" {
  config_path = "../../../_platform/networking/vpc"
}

dependency "iam" {
  config_path = "../../../_platform/security/iam"
}

inputs = {
  enabled                   = false
  vpc_id                    = try(dependency.vpc.outputs.vpc_id, "")
  subnet_id                 = try(dependency.vpc.outputs.public_subnets[0], "")
  iam_instance_profile_name = try(dependency.iam.outputs.instance_profile_names["ssm"], null)
  instance_name             = "${local.common.locals.project}-seedbox-${local.account.locals.env}"
  filter_name               = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
  instance_type             = "t3.micro"
  assign_public_ip          = true
  owners                    = "099720109477"
  open_ingress_ports        = ["5174", "3001"]
  user_data                 = <<-EOF
    #!/bin/bash
    set -euo pipefail

    apt update && apt upgrade -y

    # Add Docker's official GPG key
    apt install -y ca-certificates curl
    install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources
    tee /etc/apt/sources.list.d/docker.sources <<DOCKER_SOURCES
    Types: deb
    URIs: https://download.docker.com/linux/ubuntu
    Suites: $(. /etc/os-release && echo "$${UBUNTU_CODENAME:-$${VERSION_CODENAME}}")
    Components: stable
    Architectures: $(dpkg --print-architecture)
    Signed-By: /etc/apt/keyrings/docker.asc
    DOCKER_SOURCES

    apt update
    apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    git clone https://github.com/hotheadhacker/seedbox-lite.git /opt/seedbox-lite
    cd /opt/seedbox-lite
    IMDS_TOKEN=$(curl -sf -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
    PUBLIC_IP=$(curl -sf -H "X-aws-ec2-metadata-token: $IMDS_TOKEN" http://169.254.169.254/latest/meta-data/public-ipv4)
    printf '%s\n' \
      'NODE_ENV=production' \
      'SERVER_HOST=0.0.0.0' \
      'SERVER_PORT=3001' \
      "VITE_API_BASE_URL=http://$${PUBLIC_IP}:3001" \
      "FRONTEND_URL=http://$${PUBLIC_IP}:5174" \
      'ACCESS_PASSWORD=b8TQyeHJ75YwzFMTDUrd9xm9EJUfkwIN' \
      'BACKEND_PORT=3001' \
      'FRONTEND_PORT=5174' \
      > .env
    docker compose up -d
  EOF
}


