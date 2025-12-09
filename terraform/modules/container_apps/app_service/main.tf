# 1. Identity for the Container App
resource "azurerm_user_assigned_identity" "identity" {
  location            = var.location
  name                = "id-${var.resource_group_name}-${var.service_name}"
  resource_group_name = var.resource_group_name
}

# 2. Rights AcrPull for THIS identity
resource "azurerm_role_assignment" "acr_pull" {
  scope                = var.acr_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_user_assigned_identity.identity.principal_id
}

# 3. The Container Application
resource "azurerm_container_app" "this" {
  name                         = var.service_name
  resource_group_name          = var.resource_group_name
  container_app_environment_id = var.environment_id
  revision_mode                = "Single"

  depends_on = [azurerm_role_assignment.acr_pull]

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.identity.id]
  }

  registry {
    server   = var.acr_login_server
    identity = azurerm_user_assigned_identity.identity.id
  }

  template {
    container {
      name   = var.service_name # The container carries the name of the service
      image  = var.image_name
      cpu    = 1.0
      memory = "2Gi"

      # --- DYNAMIC BLOCK ---
      # For each key/value in the "env_vars" variable, create an env { ... } block
      dynamic "env" {
        for_each = var.env_vars
        content {
          name  = env.key
          value = env.value
        }
      }
      # ----------------------
    }
  }

  ingress {
    external_enabled = true
    target_port      = var.target_port # The port is now a variable
    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }
}