# global/main.tf

provider "azurerm" {
  features {}
}

# Define the Azure authentication variables
variable "subscription_id" {
  type        = string
  description = "Azure Subscription ID"
}

variable "tenant_id" {
  type        = string
  description = "Azure Tenant ID"
}

variable "client_id" {
  type        = string
  description = "Azure Client ID"
}

variable "client_secret" {
  type        = string
  description = "Azure Client Secret"
}

# Variables for the global resources
variable "global_resource_group_name" {
  description = "Name of the resource group for global resources"
  type        = string
  default     = "akseles-operaterra-global"
}

variable "location" {
  description = "Azure location for the global resources"
  type        = string
  default     = "North Europe"
}

# Create the resource group for global shared resources
resource "azurerm_resource_group" "global_rg" {
  name     = var.global_resource_group_name
  location = var.location
}

# Create the storage account for Terraform remote state
resource "azurerm_storage_account" "state_storage_account" {
  name                     = "operaterrastate${random_string.suffix.result}"
  resource_group_name      = azurerm_resource_group.global_rg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Generate a seudo-random suffix for globally unique storage account name that can be recreated with same seed
variable "string_to_hash" {
  type    = string
  default = "this is a random string for hashing purposes"
}

locals {
  suffix = substr(base64sha256(var.string_to_hash), 0, 4)
}

resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
}

# Create the container for Terraform state
resource "azurerm_storage_container" "state_container" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.state_storage_account.name
  container_access_type = "private"
}

# Output values for reference in deployments
output "resource_group_name" {
  value = azurerm_resource_group.global_rg.name
}

output "storage_account_name" {
  value = azurerm_storage_account.state_storage_account.name
}

output "container_name" {
  value = azurerm_storage_container.state_container.name
}

# provider "azurerm" {
#   features {}
# }

# locals {
#   state_key = "${var.environment}.terraform.tfstate" # Matches the naming convention in GitHub Actions
# }

# terraform {
#   backend "azurerm" {
#     resource_group_name  = var.state_resource_group
#     storage_account_name = var.state_storage_account_name
#     container_name       = var.state_container_name
#     key                  = local.state_key
#   }
# }

# # Variables are imported from GitHub secrets (and plain text) through the terraform.yaml CI/CD workflow

# # Super-secret variables (HAVE A GOOD HARD LOOK LATER IF THIS IS NEEDED):
# variable "subscription_id" {
#   type        = string
#   description = "Azure Subscription ID"
# }

# variable "tenant_id" {
#   type        = string
#   description = "Azure Tenant ID"
# }

# variable "client_id" {
#   type        = string
#   description = "Azure Client ID"
# }

# variable "client_secret" {
#   type        = string
#   description = "Azure Client Secret"
# }

# variable "state_storage_account_name" {
#   type        = string
#   description = "Storage account for remote state"
# }

# variable "state_container_name" {
#   type        = string
#   description = "Container for remote state"
# }

# # Context dependent variables:
# variable "environment" {
#   description = "Deployment environment passed in through GitHub actions"
#   type        = string
# }

# variable "project_name" {
#   type        = string
#   description = "Name of project"
# }

# # Non-secret variables:

# variable "location" {
#   type    = string
#   default = "North Europe"
# }

# variable "created_by_tag" {
#   description = "Unique identifier tag for resources created by this App ID (right now I use it to easily destroy my own stuff, but can be substituted for some arbitrary tag for whatever tracking the 'Company' needs)"
#   type        = string
#   default     = "akseles"
# }

# variable "state_resource_group" {
#   type        = string
#   description = "Needed for backend"
# }

# # Creating locals based on variables:
# locals {
#   resource_group_name = "${var.project_name}-${var.environment}-rg"
# }

# # Generating resources:

# resource "azurerm_resource_group" "rg" {
#   name     = local.resource_group_name
#   location = var.location
#   tags = {
#     created_by = var.created_by_tag
#   }
# }

# # Global information passed to /deployments/main.tf for use:

# output "location" {
#   value = var.location
# }

# output "created_by_tag" {
#   value = var.created_by_tag
# }

# output "environment" {
#   value = var.environment
# }

# output "resource_group_name" {
#   value = azurerm_resource_group.rg.name
# }

# output "project_name" {
#   value = var.project_name
# }

# output "resource_group_id" {
#   value = azurerm_resource_group.rg.id
# }

# output "state_storage_account_name" {
#   value = var.state_storage_account_name
# }

# output "state_container_name" {
#   value = var.state_container_name
# }

# output "subscription_id" {
#   value = var.subscription_id
# }
