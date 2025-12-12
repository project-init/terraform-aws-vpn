output "vpn_security_group_id" {
  value = module.openvpn_sg.id
  description = "The security group id."
}