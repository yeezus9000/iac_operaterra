# Generate a random string for unique storage account name
resource "random_string" "storage_suffix" {
  length  = 2
  upper   = false
  special = false
}
locals {
  blob_name = "${var.name_prefix}_blob"
  sa_name   = replace(lower("${var.name_prefix}${random_string.storage_suffix.result}"), "-", "")
}

# Define the Storage Account
resource "azurerm_storage_account" "sa" {
  name                     = local.sa_name
  location                 = var.location
  resource_group_name      = var.resource_group_name
  account_tier             = var.account_tier
  account_replication_type = var.replication_type
}

# Define the Blob Container
resource "azurerm_storage_container" "blob_container" {
  name                  = var.container_name
  storage_account_name  = local.sa_name
  container_access_type = var.container_access_type

}

resource "azurerm_storage_blob" "example" {
  name                   = local.blob_name
  storage_account_name   = local.sa_name
  storage_container_name = var.container_name
  type                   = "Block"
}
