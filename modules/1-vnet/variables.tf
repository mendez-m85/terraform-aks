variable "network_prefix" {
  description = "The prefix of your /16 vnet eg. 10.0"
}
variable "vnet_instance" {
  description = "If more vnets are required in a location and environment, add a suffix to the name. Recommended to start with 02."
  default     = ""
}
variable "name" {
  type        = string
  description = "Name of the cluster"
}
variable "location" {
  description = "Azure region"
  type        = string
}
variable "globalLocation" {
  description = "Azure region where the resource group of the core DNS exist"
  default     = "westus2"
}
variable "environment" {
  description = "Azure environment. One of dev, stage or prod"
  type        = string
}
variable "ddos_plan_id" {
  description = "Minimum $3000k/month if enabled. ID of DDOS Plan to attach to vnet. Optional. Leave blank to disable."
  type        = string
  default     = ""
}
variable "tags" {
  description = "Additional service team tags to add or overwrite the default tags"
  type        = map(any)
}
variable "publicdns" {}

locals {
  network = "${var.network_prefix}.0.0/16"
  serviceEndpoints = [
    "Microsoft.AzureActiveDirectory",
    "Microsoft.ContainerRegistry",
    "Microsoft.EventHub",
    "Microsoft.KeyVault",
    "Microsoft.Storage",
    "Microsoft.Sql",
    "Microsoft.Web"
  ]
  subnet = {
    aks              = ["${var.network_prefix}.0.0/17"]  
  }
}

variable "allocation_method" {
  type        = string
  description = "The allocation method of the ip address"
  default     = "Static"
}

variable "sku" {
  type        = string
  description = "the sku"
  default     = "Standard"
}