resource "azurerm_user_assigned_identity" "managed_identity" {
  name                  = var.resource_names.azurerm_managed_identity
  resource_group_name   = azurerm_resource_group.wide_rg.name
  location              = azurerm_resource_group.wide_rg.location
}