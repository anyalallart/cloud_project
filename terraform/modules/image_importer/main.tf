# Creation of a map to facilitate the import of multiple images
locals {
  images_map = {
    for img in var.docker_images :
    "${img.source_image_name}:${img.image_tag}" => img
  }
}

# Resource to import Docker images from GitHub Container Registry to Azure Container Registry
resource "null_resource" "import_ghcr_images" {

  for_each = local.images_map

  triggers = {
    image_version = "${each.value.source_image_name}:${each.value.image_tag}"
  }

  provisioner "local-exec" {
    # detect the OS to use the appropriate shell
    interpreter = substr(pathexpand("~"), 0, 1) == "/" ? ["/bin/bash", "-c"] : ["PowerShell", "-Command"]

    # Command to import the image from GHCR to ACR
    command = <<-EOT
      echo "Importing GHCR image: ${each.value.source_image_name}:${each.value.image_tag}"

      az acr import --name ${var.acr_name} --source ghcr.io/${each.value.source_image_name}:${each.value.image_tag} --image ${each.value.repository_name_in_acr}:${each.value.image_tag} --resource-group ${var.resource_group_name} --force

      echo "Import done for ${each.value.repository_name_in_acr}"
    EOT
  }
}