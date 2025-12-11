variable "name" {
  description = "The name of the PostgreSQL server."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the PostgreSQL server."
  type        = string
}

variable "location" {
  description = "The Azure region where the PostgreSQL server will be deployed."
  type        = string
}

variable "admin_username" {
  description = "The administrator username for the PostgreSQL server."
  type        = string
}

variable "admin_password" {
  description = "The administrator password for the PostgreSQL server."
  type        = string
  sensitive   = true
}

variable "delegated_subnet_id" {
  description = "The ID of the delegated subnet for the PostgreSQL server."
  type = string
}

variable "vnet_id" {
  description = "The ID of the virtual network to link with the private DNS zone."
  type = string
}