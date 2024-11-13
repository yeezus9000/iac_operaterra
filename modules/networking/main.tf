# modules/networking/main.tf

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.name_prefix}-vnet"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
}

resource "azurerm_subnet" "app_service_subnet" {
  name                 = "${var.name_prefix}-app-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet_prefixes[0]] # First subnet prefix (e.g., "10.0.1.0/24")
}

resource "azurerm_subnet" "database_subnet" {
  name                 = "${var.name_prefix}-db-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet_prefixes[1]] # Second subnet prefix (e.g., "10.0.2.0/24")
}

resource "azurerm_subnet" "storage_subnet" {
  name                 = "${var.name_prefix}-storage-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet_prefixes[2]] # Third subnet prefix (e.g., "10.0.3.0/24")
}

resource "azurerm_subnet" "load_balancer_subnet" {
  name                 = "${var.name_prefix}-lb-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet_prefixes[3]] # Fourth subnet prefix (e.g., "10.0.4.0/24")
}
