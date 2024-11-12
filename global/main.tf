# global/main.tf

provider "azurerm" {
  features {}
}

# Variables are imported from GitHub secrets (and plain text) through the terraform.yaml CI/CD workflow

# Super-secret variables (HAVE A GOOD HARD LOOK LATER IF THIS IS NEEDED):
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

# Context dependent variables:
variable "environment" {
  description = "Deployment environment passed in through GitHub actions"
  type        = string
}

variable "state_storage_account_name" {
  type        = string
  description = "Storage account for remote state"
}

variable "state_container_name" {
  type        = string
  description = "Container for remote state"
}

variable "project_name" {
  type        = string
  description = "Name of project"
}

# Non-secret variables:

variable "location" {
  type    = string
  default = "North Europe"
}

variable "created_by_tag" {
  description = "Unique identifier tag for resources created by this App ID (right now I use it to easily destroy my own stuff, but can be substituted for some arbitrary tag for whatever tracking the 'Company' needs)"
  type        = string
  default     = "akseles"
}

# Creating locals based on variables:
locals {
  resource_group_name = "${var.project_name}-${var.environment}-rg"
}

# Generating resources:

resource "azurerm_resource_group" "rg" {
  name     = local.resource_group_name
  location = var.location
  tags = {
    created_by = var.created_by_tag
  }
}

# Global information passed to /deployments/main.tf for use:

output "location" {
  value = var.location
}

output "created_by_tag" {
  value = var.created_by_tag
}

output "environment" {
  value = var.environment
}

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "project_name" {
  value = var.project_name
}

output "resource_group_id" {
  value = azurerm_resource_group.rg.id
}

output "state_storage_account_name" {
  value = var.state_storage_account_name
}

output "state_container_name" {
  value = var.state_container_name
}

output "subscription_id" {
  value = var.subscription_id
}
