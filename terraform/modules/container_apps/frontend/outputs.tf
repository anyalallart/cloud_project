output "name" {
    description = "Name of the frontend Container App"
    value = azurerm_container_app.frontend.name
}

output "frontend_url" {
    description = "URL of the frontend Container App"
    value = "http://${azurerm_container_app.frontend.latest_revision_fqdn}"
}