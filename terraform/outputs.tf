output "resource_group_name" {
  description = "Name of the resource group created"
  value       = azurerm_resource_group.main.name
}

output "log_analytics_workspace_id" {
  value = azurerm_log_analytics_workspace.main.id
}