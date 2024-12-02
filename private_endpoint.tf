
# private_endpoint.tf

resource "azurerm_private_endpoint" "postgresql_private_endpoint" {
  name                = "postgresql-private-endpoint"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  subnet_id           = azurerm_subnet.postgresql_subnet.id

  private_service_connection {
    name                           = "postgresqlConnection"
    private_connection_resource_id = azurerm_postgresql_flexible_server.example.id
    subresource_names              = ["postgresqlServer"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "postgresql-dns-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.postgresql.id]
  }

  # Ensure the PostgreSQL server and Subnet are created before the Private Endpoint
  depends_on = [
    azurerm_postgresql_flexible_server.example,
    azurerm_subnet.postgresql_subnet
  ]
}
