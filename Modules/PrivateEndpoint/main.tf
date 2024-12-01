resource "azurerm_private_endpoint" "private_endpoint" {
  for_each            = var.private_endpoint
  name                = each.value.private_endpoint_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = each.value.subnet_id

  private_service_connection {
    name                              = each.value.private_service_connection_name
    private_connection_resource_alias = each.value.private_connection_resource_alias
    subresource_names                 = var.subresource_names
    private_connection_resource_id    = each.value.private_connection_resource_id
    is_manual_connection              = var.is_manual_connection
    request_message                   = each.value.request_message
  }
  tags = var.tags
}