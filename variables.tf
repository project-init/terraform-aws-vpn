variable "vpc_id" {
  type        = string
  description = "The VPC ID where the VPN instance will be deployed"
}

variable "subnet_id" {
  type        = string
  description = "The subnet ID where the VPN instance will be launched (should be a public subnet)"
}

variable "instance_type" {
  type        = string
  description = "The EC2 instance type for the OpenVPN server"
  default     = "t3.small"

  validation {
    condition     = can(regex("^[tm][0-9]+[a-z]*\\.(nano|micro|small|medium|large|xlarge|[0-9]+xlarge)$", var.instance_type))
    error_message = "Instance type must be a valid EC2 instance type (e.g., t3.small, t3.medium, m5.large)."
  }
}

variable "admin_username" {
  type        = string
  description = "Administrator username for VPN Access Server web interface"

  validation {
    condition     = can(regex("^[a-zA-Z][a-zA-Z0-9_-]*$", var.admin_username))
    error_message = "Admin username must start with a letter and contain only letters, numbers, underscores, and hyphens."
  }
}

variable "admin_password" {
  type        = string
  description = "Administrator password for VPN Access Server web interface"
  sensitive   = true
}

variable "environment" {
  type        = string
  description = "The environment where the vpn is being deployed."
}
