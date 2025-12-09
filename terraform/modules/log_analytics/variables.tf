variable "name" {
  description = "The name of the Log Analytics workspace."
  type = string
}

variable "location" {
  description = "The Azure region where the Log Analytics workspace will be created."
  type = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Log Analytics workspace."
  type = string
}

variable "sku" {
  description = "The SKU (pricing tier) of the Log Analytics workspace. Default is 'PerGB2018'."
  type    = string
  default = "PerGB2018"
}

variable "retention_in_days" {
  description = "The number of days to retain logs in the Log Analytics workspace. Default is 30."
  type    = number
  default = 30
}