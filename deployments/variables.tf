# /deployments/variables.tf

# State and env variables:

variable "state_storage_account_name" {
  description = "Storage account name for Terraform state"
  type        = string
}

variable "state_container_name" {
  description = "Container name for Terraform state"
  type        = string
}

variable "state_resource_group_name" {
  description = "Resource group where the Terraform state storage account is located"
  type        = string
}

variable "environment" {
  description = "Deployment environment (e.g., dev, staging, prod)"
  type        = string
}

# Super-secret azure variables:
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

# Other:
variable "project_name" {
  type        = string
  description = "Name of project"
}

variable "location" {
  type    = string
  default = "North Europe"
}

variable "created_by_tag" {
  description = "Unique identifier tag for resources created by this App ID (right now I use it to easily destroy my own stuff, but can be substituted for some arbitrary tag for whatever tracking the 'Company' needs)"
  type        = string
  default     = "akseles"
}

# App Service variables
variable "app_service_plan_tier" {
  type    = string
  default = "B1"
}

variable "app_service_sku" {
  type    = string
  default = "S1"
}

variable "app_service_os" {
  type    = string
  default = "Windows"
}

# Database variables
variable "database_admin_username" {
  description = "Admin username for the MySQL database"
  type        = string
}

variable "database_admin_password" {
  description = "Admin password for the MySQL database"
  type        = string
  sensitive   = true
}

# Networking variables
variable "address_space" {
  type    = list(string)
  default = ["10.0.0.0/8"]
}

variable "subnet_prefixes" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24"]
}

# Storage variables
variable "account_tier" {
  type    = string
  default = "Standard"
}

variable "replication_type" {
  type    = string
  default = "LRS"
}

variable "container_name" {
  type = string
}

# Load Balancer variables
variable "frontend_port" {
  type    = number
  default = 80
}

variable "backend_port" {
  type    = number
  default = 80
}

variable "health_probe_port" {
  type    = number
  default = 80
}

variable "health_probe_request_path" {
  type    = string
  default = "/"
}
