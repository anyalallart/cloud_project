##############################################################
################### ouptut resource group ####################
##############################################################

output "resource_group_name" {
  description = "Name of the resource group created"
  value       = azurerm_resource_group.main.name
}

##############################################################
################### output log_analytics #####################
##############################################################

output "log_analytics_workspace_id" {
  value = module.log_analytics.id
}

##############################################################
####################### output ACR ###########################
##############################################################

output "acr_login_server" {
  value = module.acr.login_server
}

output "acr_admin_username" {
  value = module.acr.admin_username
}

output "acr_admin_password" {
  value = module.acr.admin_password
  sensitive = true
}
