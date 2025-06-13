# Terraform Pre-Production Infrastructure

This repository contains Terraform configuration files for provisioning the pre-production environment on Azure. It utilizes a predefined variable file (`pre-prod.tfvars`) to configure resources and manage the infrastructure lifecycle.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) (v1.x+ recommended)
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) for authentication (`az login`)
- Access to the Sure Pre-Prod Azure subscription
- Proper configuration of variables in `test.tfvars`

## Getting Started

### 1. Clone the repository

First, clone this repository to your local environment:

```bash
git clone <repository-url>
cd <repository-path>
```

### 2. Authenticate with Azure
Ensure you are authenticated with your Azure account:

```bash
az login
```
**Make sure you are in the _Sure-Prod-005_ Subscription**

* Sure-Prod-005 is the current subscription for test Environment.

This will open a browser window for you to complete the login process. Once logged in, you will have access to the appropriate Azure subscription.

###  3. Initialize Terraform
Run the following command to initialize the working directory containing Terraform configuration files. This will download the necessary provider plugins and set up your environment:

```bash
terraform init
```

### 4. Validate the Terraform Configuration
Validate the Terraform configuration to ensure it is syntactically correct:

```bash
terraform validate
```

### 5. Generate an Terraform Execution Plan

To preview the changes Terraform will make to your infrastructure, use the terraform plan command. Pass in the variable file for the testuction environment:

```bash
terraform plan --var-file=../../vars/test/test.tfvars
```
### 6. Apply Changes to Infrastructure
Apply the changes to the pre-production environment using the following command:

```bash
terraform apply --var-file=../../vars/test/test.tfvars
```
Confirm the action when prompted, and Terraform will start provisioning the infrastructure.

### 7. Destroy Infrastructure (if needed)
If you need to tear down the infrastructure, use the terraform destroy command with the same variable file:
```bash
terraform destroy --var-file=../../vars/test/test.tfvars
```

##  Directory Structure
### main.tf: 
The primary configuration file for defining the infrastructure resources.
### vars/: 
Contains the variable definition files for different environments.

sure-pre-prod/pre-prod.tfvars: Variable file specific to the pre-production environment.
##  Best Practices
* Always run terraform plan before applying changes to review the infrastructure modifications.
* Maintain backups of your variable files (.tfvars) to ensure consistency across environments.
* Use Terraform workspaces or separate state files for different environments to avoid state conflicts.

Troubleshooting
* Ensure you have the correct Azure subscription selected by running az account show.
* If authentication fails, re-run az login to refresh your credentials.
* Review the output of terraform validate and terraform plan for any syntax or configuration issues.
