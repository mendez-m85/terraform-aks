# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = "group-tfstate-storage-${var.environment}"
  location = var.location
  tags     = var.tags
}


resource "azurerm_storage_account" "example" {
  name                      = "${var.name}tfstate${var.environment}"
  resource_group_name       = azurerm_resource_group.example.name
  location                  = azurerm_resource_group.example.location
  account_tier              = var.account_tier
  account_replication_type  = var.account_replication_type
  enable_https_traffic_only = true
  account_kind              = var.account_kind

  blob_properties {
    delete_retention_policy {
      days = 30
    }
  }

  tags = var.tags

}

resource "azurerm_storage_container" "example" {
  name                  = "terraform-state"
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = var.container_access_type
}