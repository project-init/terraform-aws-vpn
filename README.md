# Project Init AWS VPN

Module used to set up a vpn in an AWS account.

## Quick Start

1. `mise format`
2. `mise docs`

## Usage

Check our [Examples](examples) for full usage information.

## Useful Docs

* [Code of Conduct](./CODE_OF_CONDUCT.md)
* [Contribution Guide](./CONTRIBUTING.md)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.81.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.81.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_openvpn_ec2"></a> [openvpn\_ec2](#module\_openvpn\_ec2) | cloudposse/ec2-instance/aws | 2.0.0 |
| <a name="module_openvpn_sg"></a> [openvpn\_sg](#module\_openvpn\_sg) | cloudposse/security-group/aws | 2.2.0 |
| <a name="module_secret"></a> [secret](#module\_secret) | project-init/secret/aws | v0.1.0 |
| <a name="module_vpn_label"></a> [vpn\_label](#module\_vpn\_label) | cloudposse/label/null | 0.25.0 |

## Resources

| Name | Type |
|------|------|
| [aws_ami.openvpn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | Administrator password for VPN Access Server web interface | `string` | n/a | yes |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | Administrator username for VPN Access Server web interface | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment where the vpn is being deployed. | `string` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The EC2 instance type for the OpenVPN server | `string` | `"t3.small"` | no |
| <a name="input_openvpn_product_code"></a> [openvpn\_product\_code](#input\_openvpn\_product\_code) | The product code of the openvpn server type you want. | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The subnet ID where the VPN instance will be launched (should be a public subnet) | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The VPC ID where the VPN instance will be deployed | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vpn_security_group_id"></a> [vpn\_security\_group\_id](#output\_vpn\_security\_group\_id) | The security group id. |
<!-- END_TF_DOCS -->