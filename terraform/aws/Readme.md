# AWS Terraform Infrastructure Module

## Overview
This module provides a secure, modular, and production-ready Terraform solution for deploying scalable infrastructure on AWS. It supports environment-specific deployments (dev, preprod, prod) and follows best practices for security, automation, and maintainability.

---

## 1. Deployment Instructions

### Prerequisites
- Terraform installed (`winget install HashiCorp.Terraform` on Windows)
- AWS CLI installed and authenticated (`aws configure`)
- Sufficient permissions in your AWS account

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
   terraform plan -var-file=envs/aws/dev-aws.tfvars
   ```
   *(Replace with `preprod-aws.tfvars` or `prod-aws.tfvars` as needed)*
4. **Apply the deployment:**
   ```bash
   terraform apply -var-file=envs/aws/dev-aws.tfvars -auto-approve
   ```
5. **Check outputs and resource status in the AWS Console.**

---

## 2. Module Structure & Rationale

### Root Module (`terraform/aws/`)
- **main.tf**: Calls the AWS module with all required variables, using environment-specific names for resources.
- **variables.tf**: Declares all variables needed for the root module.
- **outputs.tf**: Exposes key outputs (e.g., ALB DNS, S3 PEM URL).
- **provider.tf**: Configures the AWS provider.

### Environment Variable Files (`envs/aws/dev-aws.tfvars`, `envs/aws/preprod-aws.tfvars`, `envs/aws/prod-aws.tfvars`)
- Store all environment-specific values for easy switching and reproducibility.

### AWS Module (`modules/aws/`)
The AWS module (`modules/aws/`) is designed for modular, production-grade infrastructure. Below is a breakdown of each key file and its purpose:

#### `main.tf`
- Orchestrates all AWS resources using module blocks and resource definitions.
- Integrates VPC, subnets, internet gateway, security groups, EC2 launch template, auto scaling group, IAM, ALB, key pair, and S3 bucket.
- Ensures dependencies and resource relationships are explicit for reliable deployments.

#### `variables.tf`
- Declares all input variables required by the module, with types and descriptions.
- Enables environment-specific customization and safe parameterization.

#### `data.tf`
- Fetches existing AWS data (e.g., AMI IDs, availability zones) for dynamic resource configuration.
- Ensures resources use up-to-date and region-appropriate values.

#### `outputs.tf`
- Exposes key outputs such as ALB DNS name, S3 PEM file URL, VPC ID, and others.
- Facilitates integration with CI/CD, monitoring, and automation tools.

#### Resources Managed
- **VPC, Subnet, Internet Gateway**: Network isolation and internet access.
- **Security Group**: HTTP, custom web port, and SSH access control.
- **EC2 Launch Template**: Standardized instance configuration.
- **Auto Scaling Group**: Scalable, self-healing compute resources.
- **IAM user and policy**: Secure EC2 restart permissions.
- **Application Load Balancer, Target Group, Listener**: Highly available public access and health checks.
- **Key Pair and S3 bucket**: Secure PEM file management and distribution.

---

### AWS Module Variables Explained

| Variable Name         | Type        | Description                                                      |
|---------------------- |------------ |------------------------------------------------------------------|
| vpc_cidr              | string      | CIDR block for the VPC                                           |
| public_subnet_cidr    | string      | CIDR block for the public subnet                                 |
| instance_type         | string      | EC2 instance type                                                |
| ami_id                | string      | AMI ID for EC2 instances                                         |
| key_name              | string      | Name of the EC2 key pair                                         |
| allowed_ssh_cidr      | string      | CIDR block allowed to SSH                                        |
| web_port              | number      | Custom web port to open in security group                        |
| min_size              | number      | Minimum number of instances in Auto Scaling Group                |
| max_size              | number      | Maximum number of instances in Auto Scaling Group                |
| desired_capacity      | number      | Desired number of instances in Auto Scaling Group                |
| alb_internal          | bool        | Whether the ALB is internal                                      |
| environment           | string      | Environment name (dev, preprod, prod)                            |
| s3_bucket_name        | string      | Name of the S3 bucket for PEM file                               |
| tags                  | map(string) | Map of tags to apply to resources                                |

---

## 3. Why Each Resource and Practice Was Chosen

- **VPC/Subnet/IGW/Route Table**: Provides network isolation, internet access, and secure routing.
- **Security Group**: Enforces least-privilege network access, only opening required ports.
- **Key Pair & S3**: Ensures secure, auditable key management and distribution.
- **Launch Template**: Standardizes EC2 instance configuration for repeatability.
- **Auto Scaling Group**: Enables self-healing, scalable compute resources.
- **ALB**: Provides scalable, highly available public access and health checks.
- **IAM**: Follows the principle of least privilege, granting only necessary permissions.
- **Modular Structure**: Promotes reusability and easier maintenance.
- **Explicit Outputs**: Facilitates integration with CI/CD and monitoring.
- **Environment tfvars**: Enables safe, repeatable deployments for all environments.

---

## 4. Security and Best Practices

- All secrets (PEM files) are generated and stored securely in S3.
- No sensitive data is hardcoded.
- Resource names are environment-scoped to prevent collisions.
- All dependencies are explicit, ensuring correct creation order.
- Outputs are limited to what’s needed for automation and monitoring.

---

## 5. Next Steps

- Replace placeholder values in your tfvars with real AWS account and environment details.
- Run the deployment steps above.
- Monitor resources in the AWS Console.
- Integrate with Jenkins/Ansible as needed for automation.

---

## Need More?
If you need a visual diagram, further automation, or have questions about any resource or script, open an issue or contact the maintainer.
