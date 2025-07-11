// Merged Azure resources
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.vnet_address_space
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_address_prefixes
}

resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_public_ip" "pip" {
  name                = var.public_ip_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_lb" "lb" {
  name                = var.lb_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"
  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.pip.id
  }
}

resource "azurerm_lb_backend_address_pool" "backend_pool" {
  name                = "backend-pool"
  loadbalancer_id     = azurerm_lb.lb.id
}

resource "azurerm_key_vault" "keyv" {
  name                        = var.key_vault_name
  location                    = var.location
  resource_group_name         = azurerm_resource_group.rg.name
  tenant_id                   = var.tenant_id
  sku_name                    = "standard"
  purge_protection_enabled    = true
  access_policy {
    tenant_id = var.tenant_id
    object_id = var.admin_object_id
    secret_permissions = ["get", "set", "list"]
  }
}

resource "random_password" "rp" {
  length  = 20
  special = true
}

resource "azurerm_key_vault_secret" "vmss_admin_password" {
  name         = "vmss-admin-password"
  value        = random_password.rp.result
  key_vault_id = azurerm_key_vault.keyv.id
  depends_on  = [azurerm_key_vault.keyv]
}

resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
  name                = var.vmss_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  sku                 = var.vmss_sku
  instances           = var.vmss_instance_count
  admin_username      = var.admin_username
  admin_password      = azurerm_key_vault_secret.vmss_admin_password.value
  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }
  network_interface {
    name    = "nic"
    primary = true
    ip_configuration {
      name                                   = "internal"
      primary                                = true
      subnet_id                              = azurerm_subnet.subnet.id
      load_balancer_backend_address_pool_ids  = [azurerm_lb_backend_address_pool.backend_pool.id]
    }
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  depends_on = [azurerm_key_vault_secret.vmss_admin_password]
}

resource "azurerm_role_assignment" "vmss_admin" {
  scope                = azurerm_key_vault.keyv.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = var.admin_object_id
}
