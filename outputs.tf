# outputs.tf
output "postgresql_fqdn" {
  value = azurerm_postgresql_flexible_server.example.fqdn
}

output "container_app_url" {
  value = azurerm_container_app.example.latest_revision_fqdn
}
