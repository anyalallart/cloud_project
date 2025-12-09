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
