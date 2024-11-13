# Define the Azure SQL Server
resource "azurerm_mssql_server" "sql_server" {
  name                         = "${var.name_prefix}-sqlserver"
  location                     = var.location
  resource_group_name          = var.resource_group_name
  administrator_login          = var.admin_username
  administrator_login_password = var.admin_password

  version = var.version
}

# Define the Azure SQL Database
resource "azurerm_mssql_database" "sql_db" {
  name        = "${var.name_prefix}-sqldb"
  server_id   = azurerm_mssql_server.sql_server.id
  collation   = var.collation  # Set collation as required
}
