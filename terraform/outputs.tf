##############################################################
################### ouptut de resource group #################
##############################################################

output "resource_group_name" {
  description = "Name of the resource group created"
  value       = azurerm_resource_group.main.name
}

##############################################################
################### output de log_analytics ##################
##############################################################

output "log_analytics_workspace_id" {
  value = azurerm_log_analytics_workspace.main.id
}

##############################################################
####################### output de ACR ########################
##############################################################

output "acr_login_server" {
  value = azurerm_container_registry.main.login_server
}

output "acr_admin_username" {
  value = azurerm_container_registry.main.admin_username
}

output "acr_admin_password" {
  value = azurerm_container_registry.main.admin_password
  sensitive = true
}
