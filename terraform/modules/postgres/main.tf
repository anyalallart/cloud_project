resource "azurerm_postgresql_flexible_server" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  version             = "15"

  administrator_login          = var.admin_username
  administrator_password        = var.admin_password
  storage_mb                   = 32768
  sku_name                     = "B_Standard_B1ms"
  zone = "2"

  authentication {
    password_auth_enabled = true
  }
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "allow_azure" {
  name                = "AllowAzure"
  server_id           = azurerm_postgresql_flexible_server.this.id
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}
