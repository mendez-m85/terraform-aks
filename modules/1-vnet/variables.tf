variable "network_prefix" {
  description = "The prefix of your /16 vnet eg. 10.0"
}
variable "name" {
  type        = string
  description = "Name of the project"
}
variable "location" {
  description = "Azure region"
  type        = string
}
variable "globalLocation" {
  description = "Azure region where the resource group of the vnet exist"
  default     = "westus2"
}
variable "environment" {
  description = "Azure environment. eg. dev, qa, prod"
  type        = string
}
variable "tags" {
  description = "Tags to add or overwrite the default tags"
  type        = map(any)
}

locals {
  network = "${var.network_prefix}.e.g.<0.0.0/16>"
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
    aks = ["${var.network_prefix}.eg.<0.1.0/24>"]
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