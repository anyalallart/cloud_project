variable "resource_group_name" {
  type        = string
  description = "Name of the resource group where the backend will be deployed"
}

variable "location" {
  type        = string
  description = "Azure region for the backend"
}

variable "environment_id" {
  type        = string
  description = "ID of the Container App Environment (CAE) to deploy the backend in"
}

variable "frontend_image" {
  type        = string
  description = "Full path of the frontend image in ACR"
}

variable "acr_id" {
  type        = string
  description = "ID of the Azure Container Registry"
}

variable "acr_login_server" { 
  type = string 
  description = "Login server of the Azure Container Registry"
}

variable "backend_url" {
  type        = string
  description = "URL of the backend Container App" 
}
