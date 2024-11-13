# modules/networking/outputs.tf

output "vnet_id" {
  description = "ID of the Virtual Network (VNet)"
  value       = azurerm_virtual_network.vnet.id
}

output "app_service_subnet_id" {
  description = "ID of the App Service Subnet"
  value       = azurerm_subnet.app_service_subnet.id
}

output "database_subnet_id" {
  description = "ID of the Database Subnet"
  value       = azurerm_subnet.database_subnet.id
}

output "storage_subnet_id" {
  description = "ID of the Storage Subnet"
  value       = azurerm_subnet.storage_subnet.id
}

output "load_balancer_subnet_id" {
  description = "ID of the Load Balancer Subnet"
  value       = azurerm_subnet.load_balancer_subnet.id
}
