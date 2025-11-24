locals {
# Construct the full source URL (GHCR)
  ghcr_source = "ghcr.io/${var.source_image_name}:${var.image_tag}"
# Construct the target URL in the ACR
  acr_target  = "${var.repository_name_in_acr}:${var.image_tag}"
}

resource "null_resource" "import_ghcr_image" {
  
  triggers = {
    image_version = local.ghcr_source
    acr_name      = var.acr_name
  }

  provisioner "local-exec" {
    command = <<-EOT

    az login --service-principal \
      --username "${var.ghcr_username}" \
      --password "${var.ghcr_pat}" \
      --tenant "${var.tenant_id}"

    az acr import \
      --name ${var.acr_name} \
      --source ${local.ghcr_source} \
      --image ${local.acr_target} \
      --username ${var.ghcr_username} \
      --password '${var.ghcr_pat}' \
      --resource-group ${var.resource_group_name}
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}