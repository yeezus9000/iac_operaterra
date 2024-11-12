# /deployments/variables.tf

variable "state_storage_account_name" {
  description = "Storage account name for Terraform state"
  type        = string
}

variable "state_container_name" {
  description = "Container name for Terraform state"
  type        = string
}

variable "state_resource_group" {
  description = "Resource group where the Terraform state storage account is located"
  type        = string
}

variable "environment" {
  description = "Deployment environment (e.g., dev, staging, prod)"
  type        = string
}