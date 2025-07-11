# Azure data sources for dynamic configuration

# Example: Get the latest Ubuntu image for VMSS
# This is commonly needed for dynamic VM image selection

data "azurerm_platform_image" "ubuntu_latest" {
  location  = var.location
  publisher = "Canonical"
  offer     = "UbuntuServer"
  sku       = "18.04-LTS"
}

# Example: Get current client config (useful for Key Vault access policies, etc.)
data "azurerm_client_config" "current" {}

# Add more data sources only if needed for your module logic
# For example, you might add data sources for resource group, subnet, or Key Vault if you reference existing resources
