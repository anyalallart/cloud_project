# main.tf serves as the entry point for Terraform
# Terraform automatically loads all *.tf files in the folder,
# so this file can remain mostly empty for now.

# Optional: just to clarify the entry point
terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}
