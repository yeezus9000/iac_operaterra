# deployments/main.tf

provider "azurerm" {
  features {}
}

locals {
  state_key = "${var.environment}.terraform.tfstate" # Matches the naming convention in GitHub Actions
}

# Import the remote state from the global deployment
data "terraform_remote_state" "global" {
  backend = "azurerm"
  config = {
    resource_group_name  = var.state_resource_group
    storage_account_name = var.state_storage_account_name
    container_name       = var.state_container_name
    key                  = local.state_key # Matches the key in /global
  }
}

# Access the resource group details from the global state
locals {
  resource_group_name        = data.terraform_remote_state.global.outputs.resource_group_name
  resource_group_id          = data.terraform_remote_state.global.outputs.resource_group_id
  location                   = data.terraform_remote_state.global.outputs.location
  created_by_tag             = data.terraform_remote_state.global.outputs.created_by_tag
  environment                = data.terraform_remote_state.global.outputs.environment
  project_name               = data.terraform_remote_state.global.outputs.project_name
  state_storage_account_name = data.terraform_remote_state.global.outputs.state_storage_account_name
  state_container_name       = data.terraform_remote_state.global.outputs.state_container_name
  subscription_id            = data.terraform_remote_state.global.outputs.subscription_id
}

resource "azurerm_resource_group" "rg" {
  name     = "akseles-test-test-test"
  location = local.location
  tags = {
    created_by = local.created_by_tag
  }
}

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
