# Zantac Inc. Multi-Cloud Infrastructure-as-Code Solution

## Overview
This project delivers a secure, modular, and production-ready Infrastructure-as-Code (IaC) solution for Zantac Inc., supporting AWS, Azure, and GCP clouds. It enables environment-specific deployments (dev, preprod, prod), integrates with Ansible and Jenkins, and follows best practices for security, automation, and maintainability.

---

## Features
- **Multi-cloud support:** AWS, Azure, and GCP, with modular Terraform code for each.
- **Environment-specific deployments:** Easily switch between dev, preprod, and prod using tfvars files.
- **Secure credential handling:** AWS PEM files stored in S3, Azure secrets in Key Vault.
- **Jenkins CI/CD integration:** Automated pipeline for provisioning and configuration.
- **Ansible automation:** Cloud-agnostic playbooks for web server setup.
- **Explicit dependencies and outputs:** All resources are linked and outputs exposed for automation.
- **Best practices:** Follows Terraform, cloud, and security best practices throughout.

---

## Project Structure
```
ZantacInc/
  ├── terraform/
  │   ├── aws/           # AWS root module
  │   ├── azure/         # Azure root module
  │   ├── gcp/           # GCP root module
  │   └── modules/
  │   |   ├── aws/       # AWS resource modules
  │   |   ├── azure/     # Azure resource modules
  │   |   └── gcp/       # GCP resource modules
  │   └──envs/
  │     ├── aws/           # AWS environment tfvars
  │     ├── azure/         # Azure environment tfvars
  │     └── gcp/           # GCP environment tfvars
  ├── ansible/
  │   ├── aws_webserver.yml
  │   ├── azure_webserver.yml
  │   ├── gcp_webserver.yml
  │   └── inventory/terraform.py
  ├── jenkins/
  │   └── Jenkinsfile
  └── Readme.md (this file)
```

---

## Quick Start

### Prerequisites
- Terraform (`winget install HashiCorp.Terraform`)
- AWS CLI (`aws configure`), Azure CLI (`az login`), and/or GCP CLI (`gcloud auth login`)
- Ansible
- Jenkins (optional, for CI/CD)

### Deploy (example for AWS, Azure, or GCP dev)
```bash
# For AWS:
cd terraform/aws
terraform init
terraform validate
terraform plan -var-file=../../envs/aws/dev-aws.tfvars
terraform apply -var-file=../../envs/aws/dev-aws.tfvars -auto-approve

# For Azure:
cd ../azure
terraform init
terraform validate
terraform plan -var-file=../../envs/azure/dev-azure.tfvars
terraform apply -var-file=../../envs/azure/dev-azure.tfvars -auto-approve

# For GCP:
cd ../gcp
terraform init
terraform validate
terraform plan -var-file=../../envs/gcp/dev-gcp.tfvars
terraform apply -var-file=../../envs/gcp/dev-gcp.tfvars -auto-approve
```

### Provision Web Server
```bash
# For AWS:
ansible-playbook -i ansible/inventory/terraform.py ansible/aws_webserver.yml
# For Azure:
ansible-playbook -i ansible/inventory/terraform.py ansible/azure_webserver.yml
# For GCP:
ansible-playbook -i ansible/inventory/terraform.py ansible/gcp_webserver.yml
```

---

## Documentation
- See `Readme.md`, `terraform/aws/Readme.md`, `terraform/azure/Readme.md` and `terraform/gcp/Readme.md` for cloud-specific details.
- See `ansible/aws_webserver.yml`, `ansible/azure_webserver.yml`, and `ansible/gcp_webserver.yml` for playbook logic.
- See `jenkins/Jenkinsfile` for CI/CD pipeline logic.
- See `jenkins/Readme.md` for a detailed explanation of the Jenkinsfile and pipeline logic. It covers:
  - How the Jenkinsfile automates multi-cloud infrastructure provisioning and configuration using Terraform and Ansible.
  - Parameter selection for environment and cloud provider.
  - Pipeline stages: formatting, initialization, planning, applying, provisioning, and cleanup.
  - Key features: multi-cloud support, dynamic inventory, automated configuration, and workspace cleanup.
  - Usage instructions for triggering and running the pipeline in Jenkins.

Refer to `jenkins/Readme.md` for step-by-step details and best practices for CI/CD automation in this project.

---

## Security & Best Practices
- All secrets and credentials are securely managed (S3, Key Vault, GCP Service Account).
- No sensitive data is hardcoded.
- Modular, environment-scoped resource naming.
- Explicit dependencies and outputs for automation.
- Ansible playbooks support multiple Linux OS types.

---

## Dynamic Ansible Inventory with Terraform

The file `ansible/inventory/terraform.py` acts as a dynamic inventory script for Ansible. It automatically parses Terraform state files to generate an up-to-date inventory of hosts and groups for Ansible playbooks.

**How it works:**
- Reads Terraform state files (e.g., `terraform.tfstate`).
- Extracts resource details such as EC2 instance IPs and hostnames.
- Outputs a JSON inventory that Ansible can use directly.
- Supports dynamic infrastructure, so your Ansible playbooks always target the correct hosts after Terraform changes.

**Benefits:**
- Keeps Ansible inventories in sync with your cloud infrastructure.
- Eliminates manual updates to static inventory files.
- Enables seamless provisioning and configuration workflows between Terraform and Ansible.

**Typical workflow:**
1. Deploy infrastructure with Terraform.
2. Use `terraform.py` as the inventory source for Ansible.
3. Run Ansible playbooks against the infrastructure created by Terraform.

This approach is ideal for multi-cloud or dynamic environments where host details change frequently.

---

## Next Steps
- Replace placeholder values in tfvars with your real cloud/account details.
- Run the deployment and provisioning steps above.
- Monitor and manage resources via AWS, Azure, or GCP portals.
- Extend with more automation as needed.

---

## Need Help?
Open an issue or contact the maintainer for support, diagrams, or further automation examples.
