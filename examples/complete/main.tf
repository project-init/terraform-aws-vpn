module "vpn" {
  source = "project-init/vpn/aws"
  # Project Init recommends pinning every module to a specific version
  # version = "vX.X.X"

  vpc_id         = "vpc-id"
  subnet_id      = "public-subnet-id"
  admin_username = "admin"
  admin_password = "1234567890" // modify password after provisioning
  environment    = "staging"
}
