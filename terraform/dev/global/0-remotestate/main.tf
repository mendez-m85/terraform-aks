provider "azurerm" {
  features {}
}

locals {
  cwd         = reverse(split("/", path.cwd))
  environment = local.cwd[2]
  location    = "westus2"
  name        = "gss"

  tags = {
    owner       = "mmendez@keyvatech.com"
    environment = "dev"
    repo        = "azure-demo"
    managedby   = "Terraform"
    project     = "GSS"
  }
}

module "remote_state" {
  source      = "../../../../tfm/0-remotestate"
  name        = local.name
  location    = local.location
  environment = local.environment
  tags        = local.tags
}

data "azurerm_client_config" "current" {}

terraform {
  required_version = ">= 0.14.11"
  backend "azurerm" {
    resource_group_name  = "group-tfstate-storage-dev"
    storage_account_name = "gsstfstatedev"
    container_name       = "terraform-state"
    key                  = "dev-global-0-remotestate"
    snapshot             = true
  }
}