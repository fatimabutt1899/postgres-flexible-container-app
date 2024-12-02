
# resource_group.tf
resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "Australia East"
}
