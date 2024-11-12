# deployments/main.tf

module "networking" {
  source              = "../modules/networking"
  project_name        = "akseles-operaterra"
  environment         = var.environment
  location            = var.location
  resource_group_name = var.resource_group_name
}