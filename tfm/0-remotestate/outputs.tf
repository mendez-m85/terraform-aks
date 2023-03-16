output "resource_group_name" {
  value = azurerm_resource_group.example.name
}

output "terraform_state_storage_account" {
  value = azurerm_storage_account.example.name
}

output "terraform_state_storage_container_name" {
  value = azurerm_storage_container.example.name
}