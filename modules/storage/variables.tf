variable "name_prefix" {
  description = "Prefix for naming resources uniformly across environments"
  type        = string
  default     = "operaterra"
}

variable "location" {
  description = "Azure location where resources will be deployed"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group where resources will be created"
  type        = string
}

variable "account_tier" {
  description = "Tier of the storage account (Standard or Premium)"
  type        = string
}

variable "replication_type" {
  description = "Replication type for the storage account (LRS, GRS, RA-GRS, ZRS)"
  type        = string
}

variable "container_name" {
  description = "Name of the blob container to create"
  type        = string
}

variable "container_access_type" {
  description = "Access level for the blob container (private, blob, or container)"
  type        = string
}

variable "subnet_id" {
  type = string
}
