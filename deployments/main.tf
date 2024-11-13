# deployments/main.tf

provider "azurerm" {
  features {}
}

locals {
  state_key = "${var.environment}.terraform.tfstate" # Matches the naming convention in GitHub actions CI/CD workflow
}

terraform {
  backend "azurerm" {
    resource_group_name  = var.state_resource_group_name
    storage_account_name = var.state_storage_account_name
    container_name       = var.state_container_name
    key                  = local.state_key
  }
}

locals {
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

module "networking" {
  source              = "../modules/networking"
  name_prefix         = local.name_prefix
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = var.address_space
  subnet_prefixes     = var.subnet_prefixes
}

# Networking module
module "networking" {
  source              = "../modules/networking"
  name_prefix         = local.name_prefix
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = var.address_space
  subnet_prefixes     = var.subnet_prefixes
}

# App Service module
module "app_service" {
  source              = "../modules/app_service"
  name_prefix         = local.name_prefix
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  os_type          = var.app_service_os
  sku_name         = var.app_service_sku
  vnet_integration = true
  subnet_id        = module.networking.app_service_subnet_id
}

# Database module
module "database" {
  source              = "../modules/database"
  name_prefix         = local.name_prefix
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  admin_username                = var.database_admin_username
  admin_password                = var.database_admin_password
  public_network_access_enabled = false
  sku_name                      = "Basic"
  subnet_id                     = module.networking.database_subnet_id
}

# Storage module
module "storage" {
  source              = "../modules/storage"
  name_prefix         = local.name_prefix
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  account_tier          = var.account_tier
  replication_type      = var.replication_type
  container_name        = var.container_name
  container_access_type = "private"
  subnet_id             = module.networking.storage_subnet_id
}

# Load Balancer module
module "load_balancer" {
  source                    = "../modules/load_balancer"
  name_prefix               = local.name_prefix
  location                  = var.location
  resource_group_name       = azurerm_resource_group.rg.name
  frontend_port             = var.frontend_port
  backend_port              = var.backend_port
  health_probe_port         = var.health_probe_port
  health_probe_request_path = var.health_probe_request_path
  subnet_id                 = module.networking.load_balancer_subnet_id
}

# module "database" {
#   source              = "../modules/database"
#   name_prefix         = local.name_prefix
#   location            = var.location
#   resource_group_name = azurerm_resource_group.rg.name

#   # SQL Server Credentials
#   admin_username = var.database_admin_username
#   admin_password = var.database_admin_password

#   # Additional configurations
#   public_network_access_enabled = false
#   sku_name                      = "Basic"
# }


# # Storage Module
# module "storage" {
#   source              = "../modules/storage"
#   name_prefix         = local.name_prefix
#   location            = var.location
#   resource_group_name = azurerm_resource_group.rg.name
#   account_tier          = var.account_tier
#   replication_type      = var.replication_type
#   container_name        = var.container_name
#   container_access_type = "private"
# }

# # Load Balancer Module
# module "load_balancer" {
#   source              = "../modules/load_balancer"
#   name_prefix         = local.name_prefix
#   location            = var.location
#   resource_group_name = azurerm_resource_group.rg.name

#   frontend_port             = var.frontend_port
#   backend_port              = var.backend_port
#   health_probe_port         = var.health_probe_port
#   health_probe_request_path = var.health_probe_request_path
# }

# module "app_service" {
#   source              = "../modules/app_service"
#   name_prefix         = local.name_prefix
#   location            = var.location
#   resource_group_name = azurerm_resource_group.rg.name
#   os_type  = var.app_service_os
#   sku_name = var.app_service_sku
# }
