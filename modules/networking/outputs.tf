# modules/networking/outputs.tf

output "vnet_id" {
  description = "ID of the Virtual Network (VNet)"
  value       = azurerm_virtual_network.vnet.id
}

output "subnet_ids" {
  description = "List of Subnet IDs in the Virtual Network"
  value       = azurerm_subnet.subnet[*].id
}
