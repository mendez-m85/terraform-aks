output "network" {
  description = "Provides Virtual network resource name, id, cidr & resource group"
  value = {
    name  = azurerm_virtual_network.vnet.name
    id    = azurerm_virtual_network.vnet.id
    cidr  = local.network
    group = azurerm_resource_group.group-vnet.name
  }
}

output "subnets" {
  description = "Provides Subnet name, id & cidr of ask subnet"
  value = {
    aks = {
      name = azurerm_subnet.aks.name
      id   = azurerm_subnet.aks.id
      cidr = local.subnet.aks
    }
  }
}

output "resource_group" {
  description = "Provides resource group name and id"
  value = {
    name = azurerm_resource_group.group-vnet.name
    id   = azurerm_resource_group.group-vnet.id
  }
}