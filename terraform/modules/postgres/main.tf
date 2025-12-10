resource "azurerm_private_dns_zone" "pg_dns" {
  name                = "${var.name}.private.postgres.database.azure.com"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "pg_vnet_link" {
  name = "${var.name}-dns-link"
  resource_group_name = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.pg_dns.name
  virtual_network_id = var.vnet_id
}

resource "azurerm_postgresql_flexible_server" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  version             = "15"

  administrator_login    = var.admin_username
  administrator_password = var.admin_password
  storage_mb             = 32768
  sku_name               = "B_Standard_B1ms"
  zone                   = "2"

  delegated_subnet_id = var.delegated_subnet_id
  private_dns_zone_id = azurerm_private_dns_zone.pg_dns.id

  public_network_access_enabled = false

  authentication {
    password_auth_enabled = true
  }
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "allow_azure" {
  name             = "AllowAzure"
  server_id        = azurerm_postgresql_flexible_server.this.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}
