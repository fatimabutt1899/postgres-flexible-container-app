#provide.tf

# provider "azurerm" {
#   features {
# resource_group {
#       prevent_deletion_if_contains_resources = false
#     }
#     }
#   subscription_id = "YOUR_SUBSCRIPTION_ID"
#   client_id       = "YOUR_APP_ID"
#   client_secret   = "YOUR_CLIENT_SECRET"
#   tenant_id       = "YOUR_TENANT_ID"
# }






terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.3.0"
    }
  }
}


