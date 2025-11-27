variable "acr_name" {
  type        = string
  description = "Name of the Azure Container Registry"
}

variable "tenant_id" {
  type        = string
  description = "Azure tenant ID"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group where the resources will be created"
}

variable "ghcr_username" {
  type        = string
  description = "GitHub Container Registry username"
}

variable "ghcr_pat" {
  sensitive   = true
  type        = string
  description = "GitHub Container Registry Personal Access Token (with read:packages scope)"
}

variable "docker_images" {
  description = "List of GHCR images to import"
  type = list(object({
    source_image_name      = string
    repository_name_in_acr = string
    image_tag              = string
  }))
}

