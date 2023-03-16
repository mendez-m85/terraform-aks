// Resource Group for Vnet
resource "azurerm_resource_group" "group-vnet" {
  name     = "group-vnet-${var.name}-${var.location}-${var.environment}"
  location = var.location
  tags     = var.tags
}

// Vnet Block
resource "azurerm_virtual_network" "network1" {
  name                = "vnet-${var.name}-${var.location}-${var.environment}"
  location            = azurerm_resource_group.group-vnet.location
  resource_group_name = azurerm_resource_group.group-vnet.name
  address_space       = [local.network]
  tags                = var.tags

  dynamic "ddos_protection_plan" {
    for_each = length(var.ddos_plan_id) > 0 ? { id = var.ddos_plan_id } : {}
    content {
      id     = ddos_protection_plan.value
      enable = true
    }
  }
}

resource "azurerm_subnet" "aks" {
  name                                           = "aks"
  virtual_network_name                           = azurerm_virtual_network.network1.name
  resource_group_name                            = azurerm_resource_group.group-vnet.name
  address_prefixes                               = local.subnet.aks
  service_endpoints                              = local.serviceEndpoints
  enforce_private_link_endpoint_network_policies = true
}
