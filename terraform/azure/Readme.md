# Azure Terraform Infrastructure Module

## Overview
This module provides a secure, modular, and production-ready Terraform solution for deploying scalable infrastructure on Azure. It supports environment-specific deployments (dev, preprod, prod) and follows best practices for security, automation, and maintainability.

---

## 1. Deployment Instructions

### Prerequisites
- Terraform installed (`winget install HashiCorp.Terraform` on Windows)
- Azure CLI installed and authenticated (`az login`)
- Sufficient permissions in your Azure subscription

### Steps
1. **Initialize Terraform:**
   ```bash
   terraform init
   ```
2. **Validate the configuration:**
   ```bash
   terraform validate
   ```
3. **Plan the deployment:**
   ```bash
   terraform plan -var-file=envs/azure/dev-azure.tfvars
   ```
   *(Replace with `preprod-azure.tfvars` or `prod-azure.tfvars` as needed)*
4. **Apply the deployment:**
   ```bash
   terraform apply -var-file=envs/azure/dev-azure.tfvars -auto-approve
   ```
5. **Check outputs and resource status in the Azure Portal.**

---

## 2. Module Structure & Rationale

### Root Module (`terraform/azure/`)
- **main.tf**: Calls the Azure module with all required variables, using environment-specific names for resources.
- **variables.tf**: Declares all variables needed for the root module.
- **outputs.tf**: Exposes key outputs (e.g., public IP, Key Vault URI).
- **provider.tf**: Configures the AzureRM provider.

### Environment Variable Files (`envs/azure/dev-azure.tfvars`, etc.)
- Store all environment-specific values for easy switching and reproducibility.

### Azure Module (`modules/azure/`)
The Azure module (`modules/azure/`) is designed for modular, production-grade infrastructure. Below is a breakdown of each key file and its purpose:

#### `main.tf`
- Orchestrates all Azure resources using module blocks and resource definitions.
- Integrates resource group, virtual network, subnet, network security group, public IP, load balancer, VMSS, Key Vault, RBAC, and outputs.
- Ensures dependencies and resource relationships are explicit for reliable deployments.

#### `variables.tf`
- Declares all input variables required by the module, with types and descriptions.
- Enables environment-specific customization and safe parameterization.

#### `data.tf`
- Fetches existing Azure data (e.g., available VM images, regions, or other data sources) for dynamic resource configuration.
- Ensures resources use up-to-date and region-appropriate values.

#### `outputs.tf`
- Exposes key outputs such as public IP, Key Vault URI, resource IDs, and others.
- Facilitates integration with CI/CD, monitoring, and automation tools.

#### Resources Managed
- **Resource Group**: Logical grouping for lifecycle management and cost tracking.
- **Virtual Network & Subnet**: Network isolation and segmentation for security and compliance.
- **Network Security Group**: Enforces least-privilege network access.
- **Public IP & Load Balancer**: Enables scalable, highly available public access.
- **VMSS**: Provides auto-scaling, self-healing compute resources.
- **Key Vault**: Ensures secrets are never hardcoded or exposed.
- **RBAC**: Follows the principle of least privilege for managed identities.

---

## Azure Module Variables Explained

| Variable Name         | Type    | Description                                                      |
|----------------------|---------|------------------------------------------------------------------|
| environment          | string  | Deployment environment (e.g., dev, prod)                         |
| resource_group_name  | string  | Name of the Azure resource group                                 |
| location             | string  | Azure region for resource deployment                             |
| vnet_cidr            | string  | CIDR block for the virtual network                               |
| subnet_cidr          | string  | CIDR block for the subnet                                        |
| vm_size              | string  | Size of the virtual machine (e.g., Standard_DS1_v2)              |
| admin_username       | string  | Admin username for the VM                                        |
| instance_count       | number  | Number of VM instances to deploy                                 |
| image_publisher      | string  | Publisher of the VM image                                        |
| image_offer          | string  | Offer of the VM image                                            |
| image_sku            | string  | SKU of the VM image                                              |
| image_version        | string  | Version of the VM image                                          |
| web_server_port      | number  | Port number for the web server                                   |
| allowed_cidr         | string  | CIDR block allowed to access resources                           |
| aad_user_object_id   | string  | Azure Active Directory user object ID for access control         |
| tenant_id            | string  | Azure Active Directory tenant ID                                 |
| admin_object_id      | string  | Object ID of the admin user in Azure AD                          |

## 3. Why Each Resource and Practice Was Chosen

- **Resource Group**: Logical grouping for lifecycle management and cost tracking.
- **VNet/Subnet**: Network isolation and segmentation for security and compliance.
- **NSG**: Enforces least-privilege network access.
- **Public IP & Load Balancer**: Enables scalable, highly available public access.
- **VMSS**: Provides auto-scaling, self-healing compute resources.
- **Key Vault**: Ensures secrets are never hardcoded or exposed.
- **RBAC**: Follows the principle of least privilege.
- **Modular Structure**: Promotes reusability and easier maintenance.
- **Explicit Outputs**: Facilitates integration with CI/CD and monitoring.
- **Environment tfvars**: Enables safe, repeatable deployments for all environments.

---

## 4. Security and Best Practices

- All secrets are generated and stored securely in Key Vault.
- No sensitive data is hardcoded.
- Resource names are environment-scoped to prevent collisions.
- All dependencies are explicit, ensuring correct creation order.
- Outputs are limited to what’s needed for automation and monitoring.

---

## 5. Next Steps

- Replace placeholder values in your tfvars with real Azure tenant and admin object IDs.
- Run the deployment steps above.
- Monitor resources in the Azure Portal.
- Integrate with Jenkins/Ansible as needed for automation.

---

## Need More?
If you need a visual diagram, further automation, or have questions about any resource or script, open an issue or contact the maintainer.
