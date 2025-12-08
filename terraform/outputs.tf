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

##############################################################
######################## PostgreSQL ##########################
##############################################################

output "postgres_fqdn" {
  value = module.postgres.fqdn
}

output "postgres_admin_username" {
  value = module.postgres.admin_username
}

output "postgres_admin_password" {
  value     = module.postgres.admin_password
  sensitive = true
}

##############################################################
#################### output backend ACA ######################
##############################################################

output "backend_url" {
  description = "URL of the backend Container App"
  value       = module.backend.backend_url
  sensitive   = false
}
