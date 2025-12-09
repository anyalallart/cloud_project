variable "name" {
  description = "The name of the container registry."
  type = string
}

variable "location" {
  description = "The Azure region where the container registry will be created."
  type = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the container registry."
  type = string
}

variable "sku" {
  description = "The SKU name of the container registry (e.g., Basic, Standard, Premium)."
  type    = string
  default = "Basic"
}

variable "admin_enabled" {
  description = "Specifies whether the admin user is enabled for the container registry."
  type    = bool
  default = true
}
