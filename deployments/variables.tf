variable "environment" {
  description = "Deployment environment (e.g., dev, staging, prod)."
  type        = string
}

variable "location" {
  description = "Azure region for the resources."
  type        = string
  default     = "North Europe"
}

variable "resource_group_name" {
  description = "Name of the resource group where resources will be created."
  type        = string
}

variable "resource_group_id" {
  description = "ID of the resource group where resources will be created"
  type        = number
}

# Project name to ensure unique and consistent resource naming
variable "project_name" {
  description = "Project name used for naming resources consistently across modules."
  type        = string
}

variable "state_storage_account_name" {
  description = "Name of the storage account used for the Terraform remote state"
  type        = string
}

variable "state_storage_account_container" {
  description = "Name of the container in the storage account for the Terraform state file"
  type        = string
}

variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}