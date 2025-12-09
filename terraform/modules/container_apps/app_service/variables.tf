variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "environment_id" { type = string }
variable "acr_id" { type = string }
variable "acr_login_server" { type = string }

variable "service_name" {
  description = "Name of the Container App service"
  type        = string
}

variable "image_name" {
  description = "Full URL of the image (acr/image:tag)"
  type        = string
}

variable "target_port" {
  description = "The port exposed by the container (80, 8080, 3000...)"
  type        = number
}

variable "env_vars" {
  description = "Map of environment variables to inject"
  type        = map(string)
  default     = {} 
}