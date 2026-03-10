module "vpn_label" {
  source  = "cloudposse/label/null"
  version = "0.25.0" # requires Terraform >= 0.13.0

  name = "vpn"
}

data "aws_ami" "openvpn" {
  most_recent = true
  owners      = ["aws-marketplace"]

  filter {
    name   = "product-code"
    values = [var.openvpn_product_code]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

module "openvpn_sg" {
  source  = "cloudposse/security-group/aws"
  version = "2.2.0"
  context = module.vpn_label.context

  vpc_id           = var.vpc_id
  allow_all_egress = true
  rules = [
    {
      description = "OpenVPN TCP Admin Port"
      key         = "tcp"
      type        = "ingress"
      from_port   = 943
      to_port     = 943
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "OpenVPN UDP Client Port"
      key         = "udp"
      type        = "ingress"
      from_port   = 1194
      to_port     = 1194
      protocol    = "udp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "SSH Access for Admin"
      key         = "ssh"
      type        = "ingress"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"] # Restrict this to your office IP for security!
    }
  ]
}

module "openvpn_ec2" {
  source  = "cloudposse/ec2-instance/aws"
  version = "2.0.0"
  context = module.vpn_label.context

  ami                           = data.aws_ami.openvpn.id
  instance_type                 = var.instance_type
  vpc_id                        = var.vpc_id
  subnet                        = var.subnet_id
  associate_public_ip_address   = true
  security_group_enabled        = false
  security_groups               = [module.openvpn_sg.id]
  metadata_http_tokens_required = false # openvpn requires IMDSv1

  # User Data for initial setup (replace with actual script if not using Marketplace AMI)
  user_data = <<-EOF
    #!/bin/bash
    # Marketplace AMIs handle most of the install here.
    # Optional: Add post-install setup commands here.

    admin_user=${var.admin_username}
    admin_pw=${var.admin_password}
  EOF
}

module "secret" {
  source  = "project-init/secret/aws"
  version = "v0.1.0"

  environment = var.environment
  secret_name = "vpn"
}