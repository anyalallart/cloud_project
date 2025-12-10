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

variable "infrastructure_subnet_id" {
  type = string
  description = "ID of the subnet for the Container Apps Environment infrastructure"
}

variable "internal_load_balancer_enabled" {
  type = bool
  description = "Whether to enable internal load balancer for the Container Apps Environment"
  default = false
}