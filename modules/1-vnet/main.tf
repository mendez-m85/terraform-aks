// Resource Group for Vnet
resource "azurerm_resource_group" "group-vnet" {
  name     = "group-vnet-${var.name}-${var.location}-${var.environment}"
  location = var.location
  tags     = var.tags
}

// Vnet Block
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.name}-${var.location}-${var.environment}"
  location            = azurerm_resource_group.group-vnet.location
  resource_group_name = azurerm_resource_group.group-vnet.name
  address_space       = [local.network]
  tags                = var.tags

}

resource "azurerm_subnet" "aks" {
  name                                      = "aks"
  virtual_network_name                      = azurerm_virtual_network.vnet.name
  resource_group_name                       = azurerm_resource_group.group-vnet.name
  address_prefixes                          = local.subnet.aks
  service_endpoints                         = local.serviceEndpoints
  private_endpoint_network_policies_enabled = true
}

/******************************************
  Nat Gateway config
 *****************************************/

resource "azurerm_public_ip" "natip" {
  allocation_method   = var.allocation_method
  location            = azurerm_resource_group.group-vnet.location
  name                = "natip-${var.name}-${var.location}-${var.environment}"
  resource_group_name = azurerm_resource_group.group-vnet.name
  sku                 = var.sku
}

resource "azurerm_nat_gateway" "natgw" {
  name                = "nat-${var.name}-${var.location}-${var.environment}"
  location            = azurerm_resource_group.group-vnet.location
  resource_group_name = azurerm_resource_group.group-vnet.name
  sku_name            = var.sku
}

# Associate Static IP with NAT Gateway
resource "azurerm_nat_gateway_public_ip_association" "nat-ip" {
  nat_gateway_id       = azurerm_nat_gateway.natgw.id
  public_ip_address_id = azurerm_public_ip.natip.id
}

# Associate Nat Gateway with AKS subnet
resource "azurerm_subnet_nat_gateway_association" "aks" {
  nat_gateway_id = azurerm_nat_gateway.natgw.id
  subnet_id      = azurerm_subnet.aks.id
}