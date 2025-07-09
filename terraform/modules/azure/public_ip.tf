resource "azurerm_public_ip" "main" {
  name                = var.public_ip_name
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  allocation_method   = "Static"
  sku                 = "Standard"
}
