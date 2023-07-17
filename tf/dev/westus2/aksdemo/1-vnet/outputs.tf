output "network" {
  description = "Provides Virtual network resource name, id, cidr & resource group"
  value = {
    name  = module.network.network.name
    id    = module.network.network.id
    cidr  = module.network.network.cidr
    group = module.network.network.group
  }
}

output "subnet" {
  description = "Provides Subnet name, id & cidr for AKS subnet"
  value = {
    aks = {
      name = module.network.subnets.aks.name
      id   = module.network.subnets.aks.id
      cidr = module.network.subnets.aks.cidr
    }
  }
}

output "resource_group" {
  description = "Provides resource group name and id"
  value = {
    name = module.network.resource_group.name
    id   = module.network.resource_group.id
  }
}