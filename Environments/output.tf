output "location" {
  value = azurerm_resource_group.resource_group.location
}

output "resource_group_name" {
  value = azurerm_resource_group.resource_group.name
}

/* output "public_subnet_id" {
    value = module.virtual_network.public_subnet_id
} */