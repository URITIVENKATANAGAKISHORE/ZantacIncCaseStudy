resource "azurerm_lb" "main" {
  name                = var.lb_name
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  sku                 = "Standard"
  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.main.id
  }
}

resource "azurerm_lb_backend_address_pool" "main" {
  name                = "backend-pool"
  loadbalancer_id     = azurerm_lb.main.id
  resource_group_name = azurerm_resource_group.main.name
}
