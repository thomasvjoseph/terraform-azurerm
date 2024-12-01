# variables.tf
variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
}

variable "tags" {
  description = "Default tags to apply to all resources"
  type        = map(string)
  default     = {}
}

variable "network_security_groups" {
  description = "Map of NSGs with their configuration and security rules"
  type = map(object({
    name = string
    tags = optional(map(string), {})
    security_rules = list(object({
      name                         = string
      priority                     = number
      direction                    = string
      access                       = string
      protocol                     = string
      source_port_range           = string
      destination_port_range      = string
      source_address_prefix       = string
      destination_address_prefix  = string
    }))
  }))
}