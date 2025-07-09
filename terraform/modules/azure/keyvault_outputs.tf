output "key_vault_uri" {
  value = azurerm_key_vault.main.vault_uri
}
output "admin_username_secret_id" {
  value = azurerm_key_vault_secret.admin_username.id
}
output "admin_password_secret_id" {
  value = azurerm_key_vault_secret.admin_password.id
}
