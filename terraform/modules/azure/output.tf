output "resource_group_name" {
  description = "Name of the Azure resource group"
  value       = azurerm_resource_group.rg.name
}
output "vnet_id" {
  description = "ID of the Azure virtual network"
  value       = azurerm_virtual_network.vnet.id
}
output "subnet_id" {
  description = "ID of the Azure subnet"
  value       = azurerm_subnet.subnet.id
}
output "nsg_id" {
  description = "ID of the Azure network security group"
  value       = azurerm_network_security_group.nsg.id
}
output "public_ip" {
  description = "Public IP address of the Azure resource"
  value       = azurerm_public_ip.pip.ip_address
}
output "lb_public_ip_id" {
  description = "ID of the public IP used by the load balancer"
  value       = azurerm_public_ip.pip.id
}
output "lb_id" {
  description = "ID of the Azure load balancer"
  value       = azurerm_lb.lb.id
}
output "vmss_id" {
  description = "ID of the Azure VM scale set"
  value       = azurerm_linux_virtual_machine_scale_set.vmss.id
}
output "key_vault_uri" {
  description = "URI of the Azure Key Vault"
  value       = azurerm_key_vault.keyv.vault_uri
}
output "vmss_admin_password_secret_id" {
  description = "ID of the VMSS admin password secret in Key Vault"
  value       = azurerm_key_vault_secret.vmss_admin_password.id
}

output "key_vault_id" {
  description = "ID of the Azure Key Vault"
  value       = azurerm_key_vault.keyv.id
}

output "vmss_admin_password_secret_id" {
  description = "ID of the VMSS admin password secret in Key Vault"
  value       = azurerm_key_vault_secret.vmss_admin_password.id
}
