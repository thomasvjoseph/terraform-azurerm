# main.tf
resource "azurerm_network_security_group" "nsg" {
  for_each = var.network_security_groups

  name                = each.value.name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = merge(var.tags, each.value.tags)
}

resource "azurerm_network_security_rule" "rules" {
  for_each = {
    for rule in local.all_security_rules : "${rule.nsg_key}.${rule.name}" => rule
  }

  name                         = each.value.name
  priority                     = each.value.priority
  direction                    = each.value.direction
  access                       = each.value.access
  protocol                     = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg[each.value.nsg_key].name
}

locals {
  # Flatten NSG rules for easier handling
  all_security_rules = flatten([
    for nsg_key, nsg in var.network_security_groups : [
      for rule in nsg.security_rules : merge(rule, {
        nsg_key = nsg_key
      })
    ]
  ])
}