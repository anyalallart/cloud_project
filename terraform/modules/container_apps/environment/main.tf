resource "azurerm_container_app_environment" "this" {
  name                           = var.name
  location                       = var.location
  resource_group_name            = var.resource_group_name
  infrastructure_subnet_id       = var.infrastructure_subnet_id
  internal_load_balancer_enabled = var.internal_load_balancer_enabled
  # Identity required for Log Analytics integration at container app level
  identity {
    type = "SystemAssigned"
  }
  workload_profile {
    name                  = "Consumption"
    workload_profile_type = "Consumption"
  }
}
