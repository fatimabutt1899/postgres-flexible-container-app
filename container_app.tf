# container_app.tf
resource "azurerm_log_analytics_workspace" "example" {
  name                = "example-log-workspace"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
    # Ensure the Log Analytics Workspace is created first
#   depends_on = [azurerm_log_analytics_workspace.example]
}

resource "azurerm_container_app_environment" "example" {
  name                       = "Example-Environment"
  location                   = azurerm_resource_group.example.location
  resource_group_name        = azurerm_resource_group.example.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.example.id
  infrastructure_subnet_id = azurerm_subnet.container_app_subnet.id

    depends_on = [
        azurerm_log_analytics_workspace.example
    ]
}

resource "azurerm_container_app" "example" {
  name                         = "example-app"
  container_app_environment_id = azurerm_container_app_environment.example.id
  resource_group_name          = azurerm_resource_group.example.name
  revision_mode                = "Multiple"

  template {
    container {
      name   = "examplecontainerapp"
      image  = "postgres:latest"
      cpu    = 1.0
      memory = "2.0Gi"
    }
    
  }
  ingress {
    external_enabled = true
    target_port      = 80  # Use the port your application listens to (adjust if needed)
    traffic_weight {
      percentage = 100
      latest_revision = true
    }
    transport = "auto"  # This will allow only HTTP access. For HTTP + TCP, set to "Auto"
  }
  
    # Ensure the Container App Environment is created first
  depends_on = [azurerm_container_app_environment.example]
}

