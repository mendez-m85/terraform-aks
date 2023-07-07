provider "azurerm" {
  features {}
}

locals {
  cwd         = reverse(split("/", path.cwd))
  environment = local.cwd[2]
  location    = "westus2"
  name        = "aksdemo"

  tags = {
    owner       = "<owner>"
    environment = "dev"
    repo        = "terraform-aks"
    managedby   = "Terraform"
    project     = "aksdemo"
  }
}

module "remote_state" {
  source      = "../../../../modules/0-remotestate"
  name        = local.name
  location    = local.location
  environment = local.environment
  tags        = local.tags
}

data "azurerm_client_config" "current" {}

## comment out the backend block when first running terraform init
## uncomment the backend block after the storage account has been created

# terraform {
#   required_version = ">= 0.14.11"
#   backend "azurerm" {
#     resource_group_name  = "<resource_group_name>"
#     storage_account_name = "<storage_account_name>"
#     container_name       = "<container_name>"
#     key                  = "<key>"
#     snapshot             = true
#   }
# }