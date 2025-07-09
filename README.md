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
- See `terraform/modules/aws/Readme.md`, `terraform/modules/azure/Readme.md`, and `terraform/modules/gcp/Readme.md` for cloud-specific details.
- See `ansible/aws_webserver.yml`, `ansible/azure_webserver.yml`, and `ansible/gcp_webserver.yml` for playbook logic.
- See `jenkins/Jenkinsfile` for CI/CD pipeline logic.

---

## Security & Best Practices
- All secrets and credentials are securely managed (S3, Key Vault, GCP Service Account).
- No sensitive data is hardcoded.
- Modular, environment-scoped resource naming.
- Explicit dependencies and outputs for automation.
- Ansible playbooks support multiple Linux OS types.

---

## Next Steps
- Replace placeholder values in tfvars with your real cloud/account details.
- Run the deployment and provisioning steps above.
- Monitor and manage resources via AWS, Azure, or GCP portals.
- Extend with more automation as needed.

---

## Need Help?
Open an issue or contact the maintainer for support, diagrams, or further automation examples.

