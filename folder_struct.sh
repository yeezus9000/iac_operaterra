#!/bin/bash

modules=("networking" "app_service" "database" "storage")
envs=("dev" "staging" "prod")



# Modules directory for reusable components, with default files
for module in "${modules[@]}"; do
    mkdir -p "modules/$module"
    touch "modules/$module/main.tf"
    touch "modules/$module/variables.tf"
    touch "modules/$module/outputs.tf"
done

# Deployments directory with core Terraform files and environment-specific tfvars
mkdir -p "deployments"
touch "deployments/main.tf"
touch "deployments/variables.tf"
touch "deployments/outputs.tf"

# Creating environment-specific tfvars files
for env in "${envs[@]}"; do
    touch "deployments/terraform.tfvars.$env"
done

# Global settings folder for any global configurations
mkdir -p "global"
mkdir -p ".github/workflows"
touch "global/main.tf"

# Root README file
touch "README.md"