# Define the App Service Plan
resource "azurerm_service_plan" "app_plan" {
  name                = "${var.name_prefix}-appserviceplan"
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = var.os_type  # New variable to specify the OS type (e.g., Windows or Linux)
  sku_name            = var.sku_name # New variable to specify the SKU name directly (e.g., "S1")
}

# Define the App Service (Web App)
resource "azurerm_windows_web_app" "app" {
  site_config {
    
  }
  name                = "${var.name_prefix}-app"
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id = azurerm_service_plan.app_plan.id

  # Environment-specific application settings
  app_settings = merge(
    {
      "WEBSITE_RUN_FROM_PACKAGE" = "1" # Example setting to run code from a package
    },
    # var.additional_app_settings
  )

  # Optionally connect to a Virtual Network (if private connectivity is required)
  depends_on = [azurerm_service_plan.app_plan]
}
