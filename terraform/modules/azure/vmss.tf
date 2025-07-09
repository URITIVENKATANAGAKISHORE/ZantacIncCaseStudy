# VMSS references Key Vault secret for admin password
resource "azurerm_linux_virtual_machine_scale_set" "main" {
  name                = var.vmss_name
  resource_group_name = azurerm_resource_group.main.name
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
      subnet_id                              = azurerm_subnet.main.id
      load_balancer_backend_address_pool_ids  = [azurerm_lb_backend_address_pool.main.id]
    }
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  depends_on = [azurerm_key_vault_secret.vmss_admin_password]
}
