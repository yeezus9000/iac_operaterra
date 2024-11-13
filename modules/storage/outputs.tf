output "storage_account_id" {
  description = "ID of the Storage Account"
  value       = azurerm_storage_account.sa.id
}

output "storage_account_name" {
  description = "Name of the Storage Account"
  value       = azurerm_storage_account.sa.name
}

output "blob_container_name" {
  description = "Name of the Blob Container"
  value       = azurerm_storage_container.blob_container.name
}

output "blob_container_url" {
  description = "URL for the blob container"
  value       = azurerm_storage_container.blob_container.URL
}
