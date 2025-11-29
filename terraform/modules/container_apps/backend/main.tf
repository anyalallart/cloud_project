# 1. Create the user-assigned identity
resource "azurerm_user_assigned_identity" "backend_identity" {
  location            = var.location
  name                = "id-${var.resource_group_name}-backend"
  resource_group_name = var.resource_group_name
}

# 2. Assign the AcrPull role to the identity
resource "azurerm_role_assignment" "backend_acr_pull" {
  scope                = var.acr_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_user_assigned_identity.backend_identity.principal_id
}

# 3. Create the Container App
resource "azurerm_container_app" "backend" {
  name                         = "backend-api"
  resource_group_name          = var.resource_group_name
  container_app_environment_id = var.environment_id
  revision_mode                = "Single"

  # CRITICAL: Force Terraform to wait for the role assignment
  depends_on = [
    azurerm_role_assignment.backend_acr_pull
  ]

  # Attach the previously created identity
  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.backend_identity.id]
  }

  # Configure the registry WITHOUT a password
  registry {
    server   = var.acr_login_server
    # Tell the App to use this specific identity to connect
    identity = azurerm_user_assigned_identity.backend_identity.id
  }

  template {
    container {
      name   = "backend"
      image  = var.backend_image
      cpu    = 1.0
      memory = "2Gi"
    }
  }

  ingress {
    external_enabled = true
    target_port      = 8080
    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }
}