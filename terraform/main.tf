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

module "postgres" {
  source = "./modules/postgres"

  name                = "${var.project_name}-pg"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  admin_username = var.postgres_admin_username
  admin_password = var.postgres_admin_password
}

module "image_importer" {
  source = "./modules/image_importer"

  ghcr_username = var.ghcr_username
  ghcr_pat      = var.ghcr_pat
  docker_images = [
    {
      source_image_name      = "anyalallart/anyalallart/cloud_project/frontend"
      repository_name_in_acr = "frontend"
      image_tag              = "main"
    },
    {
      source_image_name      = "anyalallart/anyalallart/cloud_project/backend"
      repository_name_in_acr = "backend"
      image_tag              = "main"
    }
  ]
  resource_group_name = azurerm_resource_group.main.name
  acr_name            = module.acr.acr_name
  tenant_id           = var.tenant_id
}
