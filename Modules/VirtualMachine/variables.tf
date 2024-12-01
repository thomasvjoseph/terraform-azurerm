variable "location" {
  type        = string
  description = "The location of the resource"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
}

variable "subnet_id" {
  type        = string
  description = "The Subnet"
}

variable "nsg_id" {
  type        = string
  description = "The NSG ID"
}

variable "ssh_keys" {
  type        = string
  description = "The SSH Keys"
}