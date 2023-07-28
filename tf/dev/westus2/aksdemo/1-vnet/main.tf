provider "azurerm" {
  features {}
}

locals {
  cwd         = reverse(split("/", path.cwd))
  environment = local.cwd[3]
  location    = local.cwd[2]
  name        = local.cwd[1]

  tags = {
    owner       = "<owner>"
    environment = "dev"
    repo        = "terraform-aks"
    managedby   = "Terraform"
    project     = "aksdemo"
  }
}

module "network" {
  source         = "../../../../../modules/1-vnet"
  name           = local.name
  environment    = local.environment
  location       = local.location
  globalLocation = "westus2"
  network_prefix = "10.0"
  tags           = local.tags
}

terraform {
  required_version = ">= 0.14.11"
  backend "azurerm" {
    resource_group_name  = "<resource_group_name>"
    storage_account_name = "<storage_account_name>"
    container_name       = "<container_name>"
    key                  = "<key>"
    snapshot             = true
  }
}