output "PostgreSQL_DB_ID" {
  value = azurerm_postgresql_flexible_server.PostgreSQL.id
}

output "PostgreSQL_fqdn" {
  value = azurerm_postgresql_flexible_server.PostgreSQL.fqdn
}