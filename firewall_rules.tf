# firewall_rules.tf

# resource "azurerm_postgresql_flexible_server_firewall_rule" "azure" {
#   name             = "allow_azure"
#   server_id        = azurerm_postgresql_flexible_server.example.id
#   start_ip_address = "0.0.0.0"
#   end_ip_address   = "0.0.0.0"

#   depends_on = [azurerm_postgresql_flexible_server.example]
# }

# resource "azurerm_postgresql_flexible_server_firewall_rule" "everyone" {
#   name             = "everyone"
#   server_id        = azurerm_postgresql_flexible_server.example.id
#   start_ip_address = "0.0.0.0"
#   end_ip_address   = "255.255.255.255"

#   depends_on = [azurerm_postgresql_flexible_server.example]
# }
