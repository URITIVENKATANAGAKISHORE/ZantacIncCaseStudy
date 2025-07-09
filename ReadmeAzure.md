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
- **resource_group.tf**: Creates a resource group for all resources.
- **vnet.tf**: Provisions a Virtual Network (VNet) for secure, isolated networking.
- **subnet.tf**: Creates a subnet within the VNet.
- **nsg.tf**: Deploys a Network Security Group (NSG) to control traffic.
- **public_ip.tf**: Allocates a static public IP for external access.
- **lb.tf**: Provisions a Standard Load Balancer for distributing traffic.
- **vmss.tf**: Deploys a Virtual Machine Scale Set (VMSS) for scalable compute, using Key Vault for admin password.
- **rbac.tf**: Assigns the Contributor role to the VMSS managed identity.
- **keyvault.tf**: Creates an Azure Key Vault for secure secret storage, generates a random admin password, and stores it as a secret.
- **variables.tf**: Declares all variables for the module.
- **outputs.tf**: Exposes resource IDs, public IPs, Key Vault URIs, and secret IDs.

---

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
