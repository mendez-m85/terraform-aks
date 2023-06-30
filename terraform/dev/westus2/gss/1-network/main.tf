provider "azurerm" {
  features {}
}

locals {
  cwd         = reverse(split("/", path.cwd))
  environment = local.cwd[3]
  location    = local.cwd[2]
  name        = local.cwd[1]

  tags = {
    owner       = "mmendez@keyvatech.com"
    environment = "dev"
    repo        = "demo"
    managedby   = "Terraform"
    project     = "GSS"
  }
}

module "network" {
  source         = "../../../../../tfm/1-network"
  name           = local.name
  environment    = local.environment
  location       = local.location
  globalLocation = "westus2"
  network_prefix = "10.181"
  ddos_plan_id   = ""
  publicdns      = "mattmendez.com"
  tags           = local.tags
}

terraform {
  required_version = ">= 0.14.11"
  backend "azurerm" {
    resource_group_name  = "group-tfstate-storage-dev"
    storage_account_name = "gsstfstatedev"
    container_name       = "terraform-state"
    key                  = "gss-westus2-1-network"
    snapshot             = true
  }
}