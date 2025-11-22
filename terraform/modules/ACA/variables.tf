variable "name" {
  type        = string
  description = "Name of the Container Apps Environment"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group where ACA will be created"
}

# On conserve les variables pour log_analytics et acr, même si elles seront utilisées dans les applications
variable "log_analytics_workspace_id" {
  type        = string
  description = "ID of the Log Analytics Workspace"
}

variable "acr_id" {
  type        = string
  description = "ID of the Azure Container Registry"
}
