# modules/networking/outputs.tf

output "vnet_id" {
  description = "ID of the Virtual Network."
  value       = azurerm_virtual_network.vnet.id
}

output "app_subnet_id" {
  description = "ID of the Application subnet."
  value       = azurerm_subnet.app_subnet.id
}

output "db_subnet_id" {
  description = "ID of the Database subnet."
  value       = azurerm_subnet.db_subnet.id
}
