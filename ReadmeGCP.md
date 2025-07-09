# GCP Terraform Modules - Zantac Inc.

## Overview
This directory contains reusable, production-ready Terraform modules for provisioning core GCP infrastructure as part of the Zantac Inc. multi-cloud solution. Each module is designed for composability, security, and environment-specific deployments (dev, preprod, prod).

## Modules
- **vpc.tf**: Creates a VPC network and subnet.
- **subnet.tf**: (If separated) Manages subnet resources.
- **firewall.tf**: Configures firewall rules for secure access.
- **service_account.tf**: Provisions a service account for compute resources.
- **instance_template.tf**: Defines a VM instance template (OS, startup script, tags, etc.).
- **mig.tf**: Creates a Managed Instance Group (MIG) for scalable compute.
- **lb.tf**: Provisions a load balancer to expose the MIG to the internet.
- **outputs.tf**: Exposes key outputs (IP, resource links) for automation and Ansible.
- **variables.tf**: Declares all input variables for module flexibility.

## Usage
Each module is invoked from the GCP root module (`terraform/gcp/main.tf`). Example usage:

```hcl
module "vpc" {
  source     = "../modules/gcp"
  project_id = var.project_id
  region     = var.region
  vpc_name   = var.vpc_name
  subnet_name = var.subnet_name
  subnet_ip  = var.subnet_ip
}
```

## Inputs
See `variables.tf` for all configurable options. Typical variables include:
- `project_id`, `region`, `vpc_name`, `subnet_name`, `subnet_ip`
- `sa_name`, `image`, `machine_type`, `startup_script`, `instance_tags`
- `mig_name`, `mig_size`

## Outputs
See `outputs.tf` for all available outputs. Key outputs include:
- `vpc_name`, `subnet_self_link`, `service_account_email`, `instance_template_self_link`, `mig_self_link`, `lb_ip`

## Best Practices
- Use environment-specific tfvars for all deployments.
- Never hardcode secrets; use GCP IAM and service accounts.
- Reference outputs for automation (Ansible, Jenkins, etc.).
- Follow the same naming and modularization conventions as AWS/Azure modules.

## Security
- All resources are named and scoped per environment.
- Service accounts are used for least-privilege access.
- Firewall rules are explicit and minimal.

## Extending
- Add new modules for additional GCP services as needed.
- Use outputs to connect modules and external automation.

---
For more details, see the root `Readme.md` and the GCP root module files in `terraform/gcp/`.
