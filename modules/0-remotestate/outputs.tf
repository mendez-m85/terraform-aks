output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "terraform_state_storage_account" {
  value = azurerm_storage_account.sa.name
}

output "terraform_state_storage_container_name" {
  value = azurerm_storage_container.sc.name
}