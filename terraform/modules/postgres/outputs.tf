output "fqdn" {
  value = azurerm_postgresql_flexible_server.this.fqdn
}

output "admin_username" {
  value = var.admin_username
}

output "admin_password" {
  value     = var.admin_password
  sensitive = true
}
