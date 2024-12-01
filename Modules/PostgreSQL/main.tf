resource "azurerm_postgresql_flexible_server" "PostgreSQL" {

  name                   = var.PostgreSQL_name
  resource_group_name    = var.resource_group_name
  location               = var.location
  version                = var.PostgreSQL_version
  administrator_login    = var.PostgreSQL_administrator_login
  administrator_password = var.PostgreSQL_administrator_password
  #zone                   = var.PostgreSQL_availability_zone

  public_network_access_enabled = var.public_access_enabled

  # Set delegated_subnet_id and private_dns_zone_id based on whether public access is enabled
  delegated_subnet_id   = var.public_access_enabled ? null : var.PostgreSQL_delegated_subnet_id
  private_dns_zone_id   = var.public_access_enabled ? null : var.PostgreSQL_private_dns_zone_id
  
  backup_retention_days = var.PostgreSQL_backup_retention_days
  storage_mb            = var.storage_mb
  storage_tier          = var.storage_tier
  auto_grow_enabled     = var.PostgreSQL_auto_grow_enabled
 
  sku_name = var.PostgreSQL_sku_name

  maintenance_window {
    day_of_week  = var.PostgreSQL_maintenance_window_day_of_week
    start_hour   = var.PostgreSQL_maintenance_window_start_hour
    start_minute = var.PostgreSQL_maintenance_window_start_minute
  }
  /*   timeouts {
    create = "20m"
    delete = "10m"
    read   = "5m"
  } */

  tags = var.tags
}


resource "azurerm_postgresql_flexible_server_database" "PostgreSQL" {
  name      = var.PostgreSQL_database_name
  server_id = azurerm_postgresql_flexible_server.PostgreSQL.id

  collation  = var.PostgreSQL_database_collation
  charset    = var.PostgreSQL_database_charset
  depends_on = [azurerm_postgresql_flexible_server.PostgreSQL]

  lifecycle {
    create_before_destroy = false
    prevent_destroy       = false
  }
}