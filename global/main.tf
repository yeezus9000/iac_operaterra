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
resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
}

resource "azurerm_storage_account" "state_storage_account" {
  name                     = "operaterrastate${random_string.suffix.result}"
  resource_group_name      = azurerm_resource_group.global_rg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
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
