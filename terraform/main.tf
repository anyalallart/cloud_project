# main.tf serves as the entry point for Terraform
# Terraform automatically loads all *.tf files in the folder

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
  admin_enabled       = false
}

module "ACA" {
  source = "./modules/container_apps/environment"

  name                           = "${var.project_name}-aca-env"
  location                       = azurerm_resource_group.main.location
  resource_group_name            = azurerm_resource_group.main.name
  infrastructure_subnet_id       = module.network.subnet_ids["snet-aca"]
  internal_load_balancer_enabled = false
}

module "postgres" {
  source = "./modules/postgres"

  name                = "${var.project_name}-pg"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  admin_username = var.postgres_admin_username
  admin_password = var.postgres_admin_password

  delegated_subnet_id = module.network.subnet_ids["snet-postgres"]
  vnet_id             = module.network.vnet_id
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

module "network" {
  source = "./modules/virtual_network"

  name                = "${var.project_name}-vnet"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  address_space       = ["10.0.0.0/16"]
  subnets = {
    "snet-aca" = {
      address_prefixes = ["10.0.0.0/23"]
      delegation       = "Microsoft.App/environments"
    }

    "snet-postgres" = {
      address_prefixes = ["10.0.2.0/24"]
      delegation       = "Microsoft.DBforPostgreSQL/flexibleServers"
    }
  }
}

# 1. Creation of the Backend
module "backend" {
  source = "./modules/container_apps/app_service"

  # Infos Infra
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  environment_id      = module.ACA.environment_id
  acr_id              = module.acr.id
  acr_login_server    = module.acr.login_server

  # infos Specific to Backend
  is_external  = false
  service_name = "backend-api"
  image_name   = "${module.acr.login_server}/backend:main"
  target_port  = 8000

  env_vars = {
    #POSTGRES_HOST     = module.postgres.fqdn
    POSTGRES_DB       = "${var.project_name}-pg"
    POSTGRES_USER     = var.postgres_admin_username
    POSTGRES_PASSWORD = var.postgres_admin_password
  }
  depends_on = [module.image_importer]
}

# 2. Creation of the Frontend
module "frontend" {
  source = "./modules/container_apps/app_service" # Same source code!

  # Infos Infra
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  environment_id      = module.ACA.environment_id
  acr_id              = module.acr.id
  acr_login_server    = module.acr.login_server

  # infos Specific to Frontend
  is_external  = true
  service_name = "frontend-app"
  image_name   = "${module.acr.login_server}/frontend:main"
  target_port  = 3000

  # Injection of the REACT_APP_BACKEND_URL variable
  env_vars = {
    REACT_APP_BACKEND_URL = "http://${module.backend.fqdn}:8000"
  }

  depends_on = [module.image_importer]
}
