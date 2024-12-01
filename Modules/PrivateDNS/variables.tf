variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which the container registry will be created"
}

variable "private_dns_zone" {
  type = map(object({
    private_dns_zone_name = string
    private_dns_zone_network_link_name = string
  }))
}

variable "virtual_network_id" {
  type        = string
  description = "The ID of the virtual network"
}
