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

# Project name to ensure unique and consistent resource naming
variable "project_name" {
  description = "Project name used for naming resources consistently across modules."
  type        = string
  default     = "akseles-operaterra" # Replace with your actual project name or set dynamically in your CI/CD
}

