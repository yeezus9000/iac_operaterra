# Define the App Service Plan
resource "azurerm_service_plan" "app_plan" {
  name                = "${var.name_prefix}-appserviceplan"
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = var.os_type
  sku_name            = var.sku_name
}

# Define the App Service (Web App)
resource "azurerm_app_service" "app" {
  name                = "${var.name_prefix}-app"
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_service_plan.app_plan.id

  # Environment-specific application settings
  app_settings = merge(
    {
      "WEBSITE_RUN_FROM_PACKAGE" = "1" # Example setting to run code from a package
    },
  )
  depends_on = [azurerm_service_plan.app_plan]

}
