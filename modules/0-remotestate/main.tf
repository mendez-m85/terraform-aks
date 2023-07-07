# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = "<youruniquename>-${var.environment}"
  location = var.location
  tags     = var.tags
}


resource "azurerm_storage_account" "sa" {
  name                      = "${var.name}<replacewithyournname>${var.environment}"
  resource_group_name       = azurerm_resource_group.rg.name
  location                  = azurerm_resource_group.rg.location
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

resource "azurerm_storage_container" "sc" {
  name                  = "<youruniquename>"
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = var.container_access_type
}