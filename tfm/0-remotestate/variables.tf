variable "name" {
  type        = string
  description = "Name of the cluster"
}

variable "location" {
  type        = string
  description = "Azure region where resources will be created"
}

variable "environment" {
  type        = string
  description = "This variable describes the environment to be built"
}

variable "account_tier" {
  type    = string
  default = "Premium"
}

variable "account_replication_type" {
  type    = string
  default = "LRS"
}

variable "container_access_type" {
  type    = string
  default = "private"
}

variable "account_kind" {
  type    = string
  default = "BlockBlobStorage"
}

variable "tags" {
  type        = map(any)
  description = "additional service team tags to add or overwrite the default tags"
}