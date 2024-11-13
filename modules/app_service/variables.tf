variable "name_prefix" {
  description = "Prefix for naming resources uniformly across environments"
  type        = string
}

variable "location" {
  description = "Azure location where resources will be deployed"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group where resources will be created"
  type        = string
}

variable "os_type" {
  description = "Operating system for the App Service"
  type        = string
}

variable "sku_name" {
  description = "SKU name for the App Service"
  type        = string
}

variable "vnet_integration" {
  type = bool
}

variable "subnet_id" {
  type = string
}
