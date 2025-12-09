variable "project_name" {
  type        = string
  description = "Name of the project"
  default     = "pixelo"
}

variable "location" {
  type        = string
  description = "Azure region where the resources will be created"
  default     = "uksouth"
}

variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
  nullable    = false
}

variable "tenant_id" {
  description = "Azure tenant ID"
  type        = string
  nullable    = false
}

#################################################
############### log analytics ###################
#################################################

variable "sku" {
  type        = string
  default     = "PerGB2018"
  description = "SKU du Log Analytics Workspace"
}

variable "retention_in_days" {
  type        = number
  default     = 30
  description = "Log retention period"
}

###################################################
############## PostgreSQL #########################
###################################################

variable "postgres_admin_username" {
  type        = string
  default     = "pgadmin"
}

variable "postgres_admin_password" {
  type        = string
  sensitive   = true
}

###################################################
################ Image Importer ###################
###################################################

variable "ghcr_username" {
  description = "GitHub username for GHCR authentication."
  type      = string
}

variable "ghcr_pat" {
  description = "GitHub Personal Access Token (PAT) for GHCR authentication."
  type      = string
  sensitive = true
}
