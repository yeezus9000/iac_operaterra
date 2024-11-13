output "app_service_id" {
  description = "ID of the App Service"
  value       = azurerm_app_service.app.id
}

output "app_service_default_hostname" {
  description = "Default hostname of the App Service"
  value       = azurerm_app_service.app.default_site_hostname
}
