resource "azurerm_container_registry" "acr" {
  name                          = var.acr_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  sku                           = var.sku
  admin_enabled                 = var.admin_enabled
  public_network_access_enabled = var.public_network_access_enabled
  network_rule_bypass_option    = var.azure_services_bypass_allowed ? "AzureServices" : "None"
  data_endpoint_enabled         = var.sku == "Premium" ? var.data_endpoint_enabled : false

  dynamic "georeplications" {
    for_each = var.sku == "Premium" ? [1] : []
    content {
      location                = "East US 2"
      zone_redundancy_enabled = true
      tags                    = {}
    }
  }
  /* 
  dynamic "retention_policy" {
    for_each = var.sku == "Premium" ? [1] : []
    content {
      days    = 7
      enabled = true
    }
  }

  dynamic "trust_policy" {
    for_each = var.sku == "Premium" ? [1] : []
    content {
      enabled = true
    }
  }

  dynamic "network_rule_set" {
    for_each = length(concat(var.allowed_cidrs, var.allowed_subnets)) > 0 ? [1] : []
    content {
      default_action = "Deny"

      dynamic "ip_rule" {
        for_each = var.allowed_cidrs
        content {
          action   = "Allow"
          ip_range = ip_rule.value
        }
      }

      dynamic "virtual_network" {
        for_each = var.allowed_subnets
        content {
          action = "Allow"
          id     = virtual_network.value
        }
      }
    }
  } */
}