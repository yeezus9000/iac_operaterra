# modules/networking/variables.tf

variable "name_prefix" {
  description = "Prefix for naming resources uniformly across environments"
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

variable "address_space" {
  description = "The address space for the Virtual Network (VNet)"
  type        = list(string)
}

variable "subnet_prefixes" {
  description = "List of address prefixes for each subnet"
  type        = list(string)
}
