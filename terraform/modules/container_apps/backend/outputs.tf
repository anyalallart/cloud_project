output "backend_name" {
  description = "Name of the backend Container App"
  value       = azurerm_container_app.backend.name
}

output "url" {
  description = "URL of the backend Container App"
  value       = azurerm_container_app.backend.latest_revision_fqdn
  sensitive   = false
}
