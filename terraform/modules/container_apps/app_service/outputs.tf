output "url" {
  value = "https://${azurerm_container_app.this.latest_revision_fqdn}"
}