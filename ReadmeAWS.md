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
- **aws_main.tf**: Calls the AWS module with all required variables, using environment-specific names for resources.
- **aws_variables.tf**: Declares all variables needed for the root module.
- **aws_outputs.tf**: Exposes key outputs (e.g., ALB DNS, S3 PEM URL).
- **aws_provider.tf**: Configures the AWS provider.

### Environment Variable Files (`envs/aws/dev-aws.tfvars`, etc.)
- Store all environment-specific values for easy switching and reproducibility.

### AWS Module (`modules/aws/`)
- **vpc.tf**: Creates a VPC with a custom CIDR, internet gateway, and route tables.
- **subnet.tf**: Provisions public/private subnets for resource segmentation.
- **security_group.tf**: Defines security groups with least-privilege rules (e.g., only TCP 80/8080 open to the world).
- **keypair.tf**: Generates an EC2 key pair, stores the PEM securely in S3, and ensures explicit dependencies.
- **launch_template.tf**: Defines the EC2 launch template, referencing the key pair and security group.
- **asg.tf**: Creates an Auto Scaling Group for high availability and scalability.
- **alb.tf**: Provisions an Application Load Balancer and target group, integrating with the ASG.
- **iam.tf**: Creates IAM users/roles with minimal permissions (e.g., restart web server only).
- **outputs.tf**: Exposes resource IDs, DNS names, and S3 PEM URLs for automation and integration.
- **variables.tf**: Declares all variables for the module.

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
