output "url" {
  description = "URL of the application"
  value = "https://${azurerm_container_app.this.latest_revision_fqdn}"
}