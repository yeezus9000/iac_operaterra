provider "azurerm" {
  features {}
}

variable "location" {
  type    = string
  default = "North Europe"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}
