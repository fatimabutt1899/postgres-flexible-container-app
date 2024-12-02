# postgresql.tf

resource "azurerm_private_dns_zone" "postgresql" {
  name                = "privatelink.postgres.database.azure.com"
  resource_group_name = azurerm_resource_group.example.name
  depends_on = [ azurerm_subnet_network_security_group_association.default ]
}

resource "azurerm_private_dns_zone_virtual_network_link" "example_link" {
  name                  = "example-link"
  resource_group_name   = azurerm_resource_group.example.name
  private_dns_zone_name = azurerm_private_dns_zone.postgresql.name
  virtual_network_id    = azurerm_virtual_network.example.id

  depends_on = [azurerm_subnet.postgresql_subnet]

}

resource "azurerm_postgresql_flexible_server" "example" {
  name                   = "example-pg-server"
  location               = azurerm_resource_group.example.location
  resource_group_name    = azurerm_resource_group.example.name
  version                = "13"
  administrator_login    = "adminuser"
  administrator_password = "Password123!"
  
  storage_mb             = 32768
  storage_tier = "P30"

  sku_name               = "B_Standard_B1ms"  # Consider changing if issues persist
  
  delegated_subnet_id    = azurerm_subnet.postgresql_subnet.id
  private_dns_zone_id    = azurerm_private_dns_zone.postgresql.id
  
  public_network_access_enabled = false
  zone = "1"
  
  geo_redundant_backup_enabled = true

  tags = {
    environment = "development"
  }

  # Ensure the Subnet and DNS zone are created before the PostgreSQL server
  depends_on = [
    azurerm_subnet.postgresql_subnet,
    azurerm_private_dns_zone.postgresql,
    azurerm_private_dns_zone_virtual_network_link.example_link
  ]
}

resource "azurerm_postgresql_flexible_server_database" "example" {
  name      = "example-db-pe"
  server_id = azurerm_postgresql_flexible_server.example.id
  collation = "en_US.utf8"
  charset   = "utf8"

  lifecycle {
    prevent_destroy = false
  }

  depends_on = [azurerm_postgresql_flexible_server.example]
}

resource "azurerm_postgresql_flexible_server_configuration" "extensions" {
  name      = "azure.extensions"
  server_id = azurerm_postgresql_flexible_server.example.id
  value     = "VECTOR"
}
