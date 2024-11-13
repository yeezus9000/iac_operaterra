# deployments/outputs.tf

output "vnet_id" {
  description = "ID of the Virtual Network"
  value       = module.networking.vnet_id
}

output "app_service_hostname" {
  description = "Hostname of the App Service"
  value       = module.app_service.app_service_default_hostname
}

output "blob_container_url" {
  description = "URL of the Blob Storage container for product images"
  value       = module.storage.blob_container_url
}

# output "load_balancer_public_ip" {
#   description = "Public IP of the Load Balancer"
#   value       = module.load_balancer.load_balancer_public_ip
# }
