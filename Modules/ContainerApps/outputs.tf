output "container_app_id" {
  value = azurerm_container_app.container_app.id
}

output "container_app_name" {
  value = azurerm_container_app.container_app.name
}

/* output "custom_domain_verification_id " {
    value = azurerm_container_app.container_app.custom_domain_verification_id 
}
 */

output "container_app_fqdn" {
  value = azurerm_container_app.container_app.ingress[0].fqdn
}