# cloud_project
This is a cloud project for M2 course.


## Maintainers
[Natacha Goubert](natacha.goubert@student.junia.com)  
[Ethan Marfjan](ethan.marfjan@student.junia.com)  
[Anya Lallart](anya.lallart@student.junia.com)

## Summary

This project consists in deploying a full-stack application using GitHub Actions and GitHub Container Registry (GHCR). The application is composed of a React frontend and a Flask backend. The deployment process is automated using GitHub Actions workflows that build and push Docker images to GHCR.

## Configuration
You can create a file `terraform.tfvars` in the terraform folder to avoid filling the prompt each time you apply.

You can specify the following variables:
```shell
subscription_id = "your_subscription_id"
tenant_id = "your_tenant_id"
location = "your_preferred_location"
postgres_admin_username = "your_postgres_admin_username"
postgres_admin_password = "your_postgres_admin_password"
```

You can find your subscription ID and tenant ID in the Azure portal under "Subscriptions" or with the Azure CLI using the command:
```shell
az account show --query "{subscriptionId:id, tenantId:tenantId}"
```


## How to build and deploy
To build and deploy the application, follow these steps:
1. Clone the repository to your local machine.
2. Navigate to the project directory.
3. Configure your Azure credentials by logging in using the Azure CLI:
   ```shell
   az login
   ```
4. Navigate to the `terraform/` directory.
5. Initialize Terraform:
   ```shell
   terraform init
   terraform plan
   terraform apply
   ```

## Project Structure
- `app/frontend/`: Contains the React frontend application.
- `app/backend/`: Contains the Flask backend application.
- `.github/workflows/`: Contains GitHub Actions workflow files for CI/CD.
- `.terraform/`: Contains Terraform configuration files for infrastructure as code.
- `README.md`: Project documentation.
- `.gitignore`: Specifies files and directories to be ignored by Git.

## GitHub Actions Workflow
The GitHub Actions workflow defined in `.github/workflows/GHCR_deployment.yml` automates the process of building and pushing Docker images to GHCR. It is triggered on pushes to the `main` branch and on pull requests targeting the `main` branch. The workflow includes steps to check out the code, log in to GHCR, build the Docker images for both frontend and backend, and push them to the registry.

## File Structure
```text
.
├── .github
│   └── workflows     # CI/CD Pipelines (GitHub Actions)
│       ├── GHCR_deployment.yml     # Docker image build and deployment pipeline
│       ├── terraform_check.yml     # Code syntax and security check (CI)
│       └── terraform_doc.yml       # Automatic Terraform documentation generation
├── app
│   ├── backend
│   │   ├── Dockerfile              # Backend Docker image build
│   │   ├── main.py
│   │   └── requirements.txt
│   ├── frontend
│   │   ├── Dockerfile              # Frontend Docker image build
│   │   ├── docker-entrypoint.sh    # Container startup script
│   │   ├── index.html              # Main page
│   │   └── nginx.conf              # Web server configuration
│   └── docker-compose.yml
├── terraform
│   ├── modules
│   │   ├── container_apps          # Azure Container Apps (ACA)
│   │   │   ├── app_service
│   │   │   └── environment
│   │   ├── container_registry      # Azure Container Registry (ACR)
│   │   ├── image_importer
│   │   ├── log_analytics           # Log centralization and monitoring
│   │   ├── postgres                # PostgreSQL Database
│   │   └── virtual_network         # Network configuration (VNet, Subnets)
│   ├── main.tf                     # Main module orchestration
│   ├── outputs.tf
│   ├── provider.tf
│   ├── ressource_groups.tf
│   └── variables.tf
└── README.md

```


## Azure Resources
The Terraform configuration provisions the following Azure resources:
- Resource Group
- Azure Container Registry (ACR)
- Azure Container Apps for frontend and backend
- Azure Database for PostgreSQL
- Azure virtual network and subnet
- Azure log analytics workspace










