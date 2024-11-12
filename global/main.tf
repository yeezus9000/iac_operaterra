provider "azurerm" {
  features {}
}

variable "location" {
  type    = string
  default = "North Europe"
}

variable "created_by_tag" {
  description = "Unique identifier tag for resources created by this App ID"
  type        = string
  default     = "akseles"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
  tags = {
    created_by = var.created_by_tag
  }
}

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}
