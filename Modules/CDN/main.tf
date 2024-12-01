
resource "azurerm_cdn_frontdoor_profile" "example" {
  name                = "example-cdn-profile"
  resource_group_name = var.resource_group_name
  sku_name            = "Standard_AzureFrontDoor"

  tags = {
    environment = "Production"
  }
}