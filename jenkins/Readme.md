# Jenkins Pipeline for Multi-Cloud Terraform & Ansible Deployment

This Jenkinsfile automates the provisioning and configuration of infrastructure across AWS, Azure, and GCP using Terraform and Ansible. It supports environment-specific deployments (dev, preprod, prod) and cloud selection via pipeline parameters.

## What the Jenkinsfile Does

1. **Parameter Selection**
   - Lets you choose the target environment (`dev`, `preprod`, `prod`) and cloud provider (`aws`, `azure`, `gcp`) at runtime.

2. **Environment Setup**
   - Sets environment variables for Terraform and Ansible based on your selections.
   - Dynamically chooses the correct Terraform directory, variable file, plan file, and Ansible playbook.

3. **Pipeline Stages**
   - **Terraform Format**: Checks and enforces Terraform code formatting.
   - **Terraform Init**: Initializes the Terraform working directory for the selected cloud.
   - **Terraform Plan**: Generates an execution plan using the correct variable file and outputs a plan file.
   - **Terraform Apply**: Applies the Terraform plan to provision infrastructure.
   - **Ansible Provision**: Runs the appropriate Ansible playbook using a dynamic inventory generated from Terraform state (`inventory/terraform.py`).

4. **Post Actions**
   - Cleans up Terraform state and plan files after the pipeline completes.

## Key Features
- **Multi-Cloud Support**: Works with AWS, Azure, and GCP by switching directories and files based on parameters.
- **Environment-Specific Deployments**: Uses tfvars files for dev, preprod, and prod.
- **Infrastructure as Code**: Provisions resources with Terraform, then configures them with Ansible.
- **Dynamic Inventory**: Ansible uses `inventory/terraform.py` to read the latest Terraform state and target the correct hosts.
- **Automated Cleanup**: Removes temporary files to keep the workspace clean.

## Usage
1. Trigger the pipeline in Jenkins.
2. Select the desired environment and cloud provider.
3. The pipeline will:
   - Format, initialize, plan, and apply Terraform for the selected cloud and environment.
   - Run the corresponding Ansible playbook for post-provisioning configuration.
   - Clean up temporary files.

This pipeline enables fully automated, repeatable, and multi-cloud infrastructure deployments with minimal manual intervention.

---

