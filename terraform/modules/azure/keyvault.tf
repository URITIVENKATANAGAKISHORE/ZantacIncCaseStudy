resource "azurerm_key_vault" "main" {
  name                        = var.key_vault_name
  location                    = var.location
  resource_group_name         = azurerm_resource_group.main.name
  tenant_id                   = var.tenant_id
  sku_name                    = "standard"
  soft_delete_enabled         = true
  purge_protection_enabled    = true
  access_policy {
    tenant_id = var.tenant_id
    object_id = var.admin_object_id
    secret_permissions = ["get", "set", "list"]
  }
}

resource "random_password" "admin" {
  length  = 20
  special = true
}

resource "azurerm_key_vault_secret" "vmss_admin_password" {
  name         = "vmss-admin-password"
  value        = random_password.admin.result
  key_vault_id = azurerm_key_vault.main.id
}
