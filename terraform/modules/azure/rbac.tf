resource "azurerm_role_assignment" "vmss_contributor" {
  scope                = azurerm_resource_group.main.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_linux_virtual_machine_scale_set.main.identity[0].principal_id
}
