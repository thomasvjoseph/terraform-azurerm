# NOTE: the Name used for Redis needs to be globally unique
resource "azurerm_redis_cache" "redis" {
  name                          = var.redis_cache_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  capacity                      = var.capacity
  family                        = var.family
  sku_name                      = var.sku_name
  shard_count                   = var.sku_name == "Premium" ? var.shard_count : 0
  non_ssl_port_enabled          = var.non_ssl_port_enabled
  minimum_tls_version           = var.minimum_tls_version
  public_network_access_enabled = var.public_network_access_enabled

  redis_configuration {

  }

  tags = var.tags
}