output "storage_account_id" {
    value = azurerm_storage_account.storage_account.id
}

output "storage_account_name" {
    value = azurerm_storage_account.storage_account.name
}

output "blob_url" {
    value = azurerm_storage_blob.storage_blob.url
}