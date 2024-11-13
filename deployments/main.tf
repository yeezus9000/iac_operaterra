# deployments/main.tf

provider "azurerm" {
  features {}
}

locals {
  state_key = "${var.environment}.terraform.tfstate" # Matches the naming convention in GitHub Actions
}

terraform {
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
}

# resource "azurerm_resource_group" "rg" {
#   name     = "akseles-test-test-test"
#   location = var.location
#   tags = {
#     created_by = var.created_by_tag
#   }
# }

# module "networking" {
#   source              = "../modules/networking"
#   project_name        = local.project_name
#   location            = local.location
#   resource_group_name = local.resource_group_name
#   resource_group_id   = local.resource_group_id
#   environment         = var.environment
# }

# Repeat for other modules as needed
# module "app_service" {
#   source              = "../modules/app_service"
#   resource_group_name = local.resource_group_name
#   resource_group_id   = local.resource_group_id
#   environment         = var.environment
# }

# module "database" {
#   source              = "../modules/database"
#   resource_group_name = local.resource_group_name
#   resource_group_id   = local.resource_group_id
#   environment         = var.environment
# }

# module "storage" {
#   source              = "../modules/storage"
#   resource_group_name = local.resource_group_name
#   resource_group_id   = local.resource_group_id
#   environment         = var.environment
# }
