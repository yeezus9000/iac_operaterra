# Generate a random string for unique storage account name
resource "random_string" "storage_suffix" {
  length  = 4
  upper   = false
  special = false
}
locals {
  blob_name = "${var.name_prefix}_blob"
  sa_name   = regexreplace("${var.name_prefix}${random_string.storage_suffix.result}", "[^a-zA-Z0-9]", "")
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
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = var.container_access_type

}



resource "azurerm_storage_blob" "example" {
  name                   = local.blob_name
  storage_account_name   = azurerm_storage_account.sa.name
  storage_container_name = azurerm_storage_container.blob_container
  type                   = "Block"
}
