# Define the Azure SQL Server
resource "azurerm_mssql_server" "sql_server" {
  name                          = "${var.name_prefix}-sqlserver"
  location                      = var.location
  resource_group_name           = var.resource_group_name
  administrator_login           = "4dm1n157r470r"
  administrator_login_password  = "4-v3ry-53cr37-p455w0rd"
  public_network_access_enabled = var.public_network_access_enabled
  version                       = var.sql_version
}

# Define the Azure SQL Database
resource "azurerm_mssql_database" "sql_db" {
  name      = "${var.name_prefix}-sqldb"
  server_id = azurerm_mssql_server.sql_server.id
  collation = var.collation
}
