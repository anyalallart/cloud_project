# main.tf serves as the entry point for Terraform
# Terraform automatically loads all *.tf files in the folder,
# so this file can remain mostly empty for now.

# Optional: just to clarify the entry point
terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}


# Modules
module "log_analytics" {
  source              = "./modules/log_analytics"
  name                = "${var.project_name}-law"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku                 = var.sku
  retention_in_days   = var.retention_in_days
}

module "acr" {
  source              = "./modules/container_registry"
  name                = "${var.project_name}acr"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku                 = "Basic"
  admin_enabled       = true
}

module "ACA" {
  source = "./modules/container_apps"

  name                = "${var.project_name}-aca-env"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  # Outputs des modules existants
  log_analytics_workspace_id = module.log_analytics.id
  acr_id                     = module.acr.id
}