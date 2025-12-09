resource "azurerm_container_app_environment" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  # Identity required for Log Analytics integration at container app level
  identity {
    type = "SystemAssigned"
  }
}
