provider "azurerm" {
  features {}
}

locals {
  cwd         = reverse(split("/", path.cwd))
  environment = local.cwd[2]
  location    = "westus2"
  name        = "aksdemo"

  tags = {
    owner       = "mmendez@keyvatech.com"
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

terraform {
  required_version = ">= 0.14.11"
  backend "azurerm" {
    resource_group_name  = "rg-tfstate-storage-dev"
    storage_account_name = "aksdemotfstatedev"
    container_name       = "terraform-state"
    key                  = "dev-global-0-remotestate"
    snapshot             = true
  }
}