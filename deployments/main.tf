# deployments/main.tf

provider "azurerm" {
  features {}
}

locals {
  state_key = "${var.environment}.terraform.tfstate" # Matches the naming convention in GitHub Actions
}

terraform {
  #   required_providers {
  #   azurerm = {
  #     source  = "hashicorp/azurerm"
  #     version = "4.3.0"
  #   }
  #   random = {
  #     source  = "hashicorp/random"
  #     version = "3.6.3"
  #   }
  # }
  backend "azurerm" {
    resource_group_name  = var.state_resource_group_name
    storage_account_name = var.state_storage_account_name
    container_name       = var.state_container_name
    key                  = local.state_key # Use the same key as in /global
  }
}

locals {
  suffix = substr(sha256(var.string_to_hash), 0, 4)
  # See comment in /global/main.tf about this pseudo-random suffix (it's not really in use)
  name_prefix         = "${var.project_name}-${var.environment}"
  resource_group_name = "${local.name_prefix}-rg"
}

resource "azurerm_resource_group" "rg" {
  name     = local.resource_group_name
  location = var.location
  tags = {
    created_by = var.created_by_tag
  }
}

module "app_service" {
  source              = "../modules/app_service"
  name_prefix         = local.name_prefix
  location            = var.location
  resource_group_name = local.resource_group_name

  os_type  = var.app_service_os
  sku_name = var.app_service_sku
}

# Database is not working, come back to it later. Issues with API "login"
# module "database" {
#   source              = "../modules/database"
#   name_prefix         = local.name_prefix
#   location            = var.location
#   resource_group_name = local.resource_group_name

#   # SQL Server Credentials
#   admin_username = var.database_admin_username
#   admin_password = var.database_admin_password

#   # Additional configurations
#   public_network_access_enabled = false
#   sku_name                      = "Basic"
# }

# module "networking" {
#   source = "../modules/networking"
#   # These values will default to "Norway East" and other defaults unless overridden
#   name_prefix         = local.name_prefix              # Defaults to "operaterra"
#   location            = var.location                   # Defaults to "Norway East"
#   resource_group_name = var.resource_group_name        # Defaults to "operaterra-network-rg"
#   address_space       = ["10.1.0.0/16"]                # Optional: override if needed
#   subnet_prefixes     = ["10.1.1.0/24", "10.1.2.0/24"] # Optional: override if needed
# }




# # Storage Module
# module "storage" {
#   source              = "../modules/storage"
#   name_prefix         = local.name_prefix
#   location            = var.location
#   resource_group_name = var.resource_group_name

#   # Storage configuration
#   account_tier          = "Standard"
#   replication_type      = "LRS"
#   container_name        = "product-images"
#   container_access_type = "private"
# }

# # Load Balancer Module
# module "load_balancer" {
#   source              = "../modules/load_balancer"
#   name_prefix         = local.name_prefix
#   location            = var.location
#   resource_group_name = var.resource_group_name

#   frontend_port             = 80
#   backend_port              = 80
#   health_probe_port         = 80
#   health_probe_request_path = "/health"
# }
