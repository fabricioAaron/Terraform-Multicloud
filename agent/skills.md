# Terraform Multi-Cloud Agent Skills

This document aggregates the essential rules, best practices, and validation steps for maintaining the `Terraform-Multicloud` project across AWS and Azure. It acts as a comprehensive skill set for the AI Agent to ensure high-quality, secure, and idiomatic Terraform code.

## 1. General Terraform Best Practices & Style Guide

### Code Structure and Style
- **Formatting**: Always format code using standard HashiCorp conventions (`terraform fmt`). Use 2 spaces for indentation.
- **Naming Conventions**: 
  - Use `snake_case` for all resource names, variable names, and outputs.
  - Avoid repeating the resource type in the resource name (e.g., use `resource "aws_vpc" "main"` instead of `resource "aws_vpc" "main_vpc"`).
  - Use descriptive names that indicate the resource's purpose.
- **Variable Definitions**:
  - Always provide a `description` and `type` for every variable.
  - Use validation rules (`validation {}` block) for variables to ensure correct inputs.
- **Outputs**:
  - Provide a `description` for every output.
  - Mark sensitive outputs with `sensitive = true`.
- **State Management**:
  - Never store sensitive information (e.g., passwords, private keys) in plain text variables. 
  - Ensure the remote state backend is properly configured and encrypted.

### Modules
- Prefer using official modules from the Terraform Registry when possible.
- If creating custom modules, structure them with `main.tf`, `variables.tf`, `outputs.tf`, and `README.md`.
- Pin module versions to avoid unexpected breaking changes.

## 2. AWS Specific Guidelines

- **Provider Configuration**:
  - Always pin the `aws` provider version (`~> 5.0` or similar).
  - Use default tags at the provider level to ensure consistent tagging across all resources:
    ```hcl
    provider "aws" {
      default_tags {
        tags = {
          Environment = var.environment
          Project     = "Multicloud"
          ManagedBy   = "Terraform"
        }
      }
    }
    ```
- **Security**:
  - Ensure S3 buckets have block public access enabled and versioning turned on.
  - IAM policies should follow the principle of least privilege. Use `aws_iam_policy_document` data sources instead of inline JSON strings.
  - Ensure EBS volumes and RDS instances have encryption at rest enabled (`encrypted = true`).

## 3. Azure (AzureRM) Specific Guidelines

- **Provider Configuration**:
  - Always pin the `azurerm` provider version.
  - Ensure the `features {}` block is present in the provider configuration.
- **Resource Groups**:
  - Group resources logically into Resource Groups.
  - Inherit tags or apply consistent tagging to all resources within a Resource Group.
- **Security**:
  - Ensure Storage Accounts have "Secure transfer required" enabled (`https_traffic_only_enabled = true`).
  - Key Vaults should be used for secrets management, and access policies should be strictly controlled.
  - Virtual Machines should use Managed Disks, and Network Security Groups (NSGs) should be attached to subnets or network interfaces to restrict traffic.

## 4. Code Validation & Security Checks

Before proposing or finalizing any Terraform changes, the agent must ensure the following validation steps pass:

1. **Syntax & Formatting**:
   - The code must be syntactically valid HCL.
   - Run `terraform validate` conceptually to check for missing arguments, undeclared variables, or invalid references.
2. **Security Scans**:
   - Conceptually evaluate the code against `tfsec` or `checkov` rules.
   - Look for hardcoded secrets, open security groups (e.g., `0.0.0.0/0` on port 22/3389), and unencrypted data stores.
3. **Plan Review**:
   - Ensure the execution plan matches the intent.
   - Warn the user if the plan involves unexpected destructive actions (e.g., replacing a database).
4. **Dry-Run Checks**:
   - Ensure there are no dependency cycles.
   - Verify that all outputs reference existing attributes of resources.

---

**Instructions for the AI Agent:**
When interacting with this repository, prioritize these rules. If the user asks to create a new resource (e.g., an EC2 instance or an Azure VM), automatically apply the relevant security best practices (like encryption, tagging, and network security) even if not explicitly requested.
