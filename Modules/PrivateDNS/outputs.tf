output "private_dns_zone_id" {
  value = { for k in azurerm_private_dns_zone.private_dns_zone : k.id => k.id }
}

output "private_dns_zone_names" {
  value = { for k in azurerm_private_dns_zone.private_dns_zone : k.name => k.name }
}