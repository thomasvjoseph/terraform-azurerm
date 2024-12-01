# outputs.tf
output "network_security_groups" {
  description = "Map of created NSGs and their details"
  value = {
    for key, nsg in azurerm_network_security_group.nsg : key => {
      id   = nsg.id
      name = nsg.name
    }
  }
}