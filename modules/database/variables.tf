variable "name_prefix" {
  description = "Prefix for naming resources uniformly across environments"
  type        = string
}

variable "location" {
  description = "Azure location where resources will be deployed"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group resources will be created"
  type        = string
}

variable "admin_username" {
  description = "Administrator username for SQL Server"
  type        = string
}

variable "admin_password" {
  description = "Administrator password for SQL Server"
  type        = string
}

variable "public_network_access_enabled" {
  description = "Public network access bool"
  type        = bool
  default     = false
}

variable "sku_name" {
  description = "SKU name for SQL Database "
  type        = string
  default     = "Basic"
}

variable "collation" {
  description = "Collation settings for the database"
  type        = string
  default     = "SQL_Latin1_General_CP1_CI_AS"
}

variable "version" {
    type = string
    default = "12.0"
}
