resource "azurerm_storage_account" "storage_account" {
  name                     = "examplestoracc"
  resource_group_name        = var.resource_group_name
  location                   = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "storage_container" {
  name                  = "content"
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "storage_blob" {
  name                   = "my-awesome-content.zip"
  storage_account_name   = azurerm_storage_account.storage_account.name
  storage_container_name = azurerm_storage_container.storage_container.name
  type                   = "Block"
  source                 = "some-local-file.zip"
}