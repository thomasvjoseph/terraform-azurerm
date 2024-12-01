output "private_endpoint_id" {
  description = "The ID of the private endpoint."
  value       = { for k in azurerm_private_endpoint.private_endpoint : k.name => k.id }
}