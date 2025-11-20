variable "project_name" {
  type        = string
  description = "Name of the project"
  default     = "pixelo"
}

variable "location" {
  type        = string
  description = "Azure region where the resources will be created"
  default     = "UkSouth"
}

variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
  nullable    = false
}
