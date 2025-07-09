output "resource_group_name" {
  value = azurerm_resource_group.main.name
}
output "vnet_id" {
  value = azurerm_virtual_network.main.id
}
output "subnet_id" {
  value = azurerm_subnet.main.id
}
output "nsg_id" {
  value = azurerm_network_security_group.main.id
}
output "public_ip" {
  value = azurerm_public_ip.main.ip_address
}
output "lb_public_ip_id" {
  value = azurerm_public_ip.main.id
}
output "lb_id" {
  value = azurerm_lb.main.id
}
output "vmss_id" {
  value = azurerm_linux_virtual_machine_scale_set.main.id
}
output "key_vault_uri" {
  value = azurerm_key_vault.main.vault_uri
}
output "vmss_admin_password_secret_id" {
  value = azurerm_key_vault_secret.vmss_admin_password.id
}
