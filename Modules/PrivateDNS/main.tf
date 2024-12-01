resource "azurerm_private_dns_zone" "private_dns_zone" {
  for_each            = var.private_dns_zone
  name                = each.value.private_dns_zone_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "virtual_network_link" {
  for_each              = var.private_dns_zone
  name                  = each.value.private_dns_zone_network_link_name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone[each.key].name
  virtual_network_id    = var.virtual_network_id
  resource_group_name   = var.resource_group_name
}