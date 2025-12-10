<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 4.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ACA"></a> [ACA](#module\_ACA) | ./modules/container_apps/environment | n/a |
| <a name="module_acr"></a> [acr](#module\_acr) | ./modules/container_registry | n/a |
| <a name="module_backend"></a> [backend](#module\_backend) | ./modules/container_apps/app_service | n/a |
| <a name="module_frontend"></a> [frontend](#module\_frontend) | ./modules/container_apps/app_service | n/a |
| <a name="module_image_importer"></a> [image\_importer](#module\_image\_importer) | ./modules/image_importer | n/a |
| <a name="module_log_analytics"></a> [log\_analytics](#module\_log\_analytics) | ./modules/log_analytics | n/a |
| <a name="module_network"></a> [network](#module\_network) | ./modules/virtual_network | n/a |
| <a name="module_postgres"></a> [postgres](#module\_postgres) | ./modules/postgres | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ghcr_pat"></a> [ghcr\_pat](#input\_ghcr\_pat) | GitHub Personal Access Token (PAT) for GHCR authentication. | `string` | n/a | yes |
| <a name="input_ghcr_username"></a> [ghcr\_username](#input\_ghcr\_username) | GitHub username for GHCR authentication. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Azure region where the resources will be created | `string` | `"uksouth"` | no |
| <a name="input_postgres_admin_password"></a> [postgres\_admin\_password](#input\_postgres\_admin\_password) | n/a | `string` | n/a | yes |
| <a name="input_postgres_admin_username"></a> [postgres\_admin\_username](#input\_postgres\_admin\_username) | n/a | `string` | `"pgadmin"` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Name of the project | `string` | `"pixelo"` | no |
| <a name="input_retention_in_days"></a> [retention\_in\_days](#input\_retention\_in\_days) | Log retention period | `number` | `30` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | SKU of the Log Analytics Workspace | `string` | `"PerGB2018"` | no |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | Azure subscription ID | `string` | n/a | yes |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | Azure tenant ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_acr_login_server"></a> [acr\_login\_server](#output\_acr\_login\_server) | n/a |
| <a name="output_frontend_website_url"></a> [frontend\_website\_url](#output\_frontend\_website\_url) | n/a |
| <a name="output_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#output\_log\_analytics\_workspace\_id) | n/a |
| <a name="output_postgres_admin_password"></a> [postgres\_admin\_password](#output\_postgres\_admin\_password) | n/a |
| <a name="output_postgres_admin_username"></a> [postgres\_admin\_username](#output\_postgres\_admin\_username) | n/a |
| <a name="output_postgres_fqdn"></a> [postgres\_fqdn](#output\_postgres\_fqdn) | n/a |
<!-- END_TF_DOCS -->