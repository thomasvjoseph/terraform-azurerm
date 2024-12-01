
data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "keyvault" {
  resource_group_name         = var.resource_group_name
  location                    = var.location
  name                        = var.key_vault_name
  enabled_for_disk_encryption = var.enabled_for_disk_encryption
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = var.soft_delete_retention_days
  purge_protection_enabled    = var.purge_protection_enabled
  sku_name                    = var.sku_name

  dynamic "access_policy" {
    for_each = var.access_policies != null ? [1] : []
    content {
      tenant_id           = data.azurerm_client_config.current.tenant_id
      object_id           = var.access_policies.object_id
      key_permissions     = var.access_policies.key_permissions
      secret_permissions  = var.access_policies.secret_permissions
      storage_permissions = var.access_policies.storage_permissions
    }
  }

  dynamic "network_acls" {
    for_each = var.network_acls != null ? [1] : []
    content {
      bypass                     = var.network_acls.bypass
      default_action             = var.network_acls.default_action
      ip_rules                   = var.network_acls.ip_rules
      virtual_network_subnet_ids = var.network_acls.virtual_network_subnet_ids
    }
  }

  tags = var.tags
}