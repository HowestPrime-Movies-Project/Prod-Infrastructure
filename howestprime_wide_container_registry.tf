resource "azurerm_container_registry" "howestprime_wide_cr" {
    name                    = var.resource_names.azurerm_container_registry_howestprime
    resource_group_name     = azurerm_resource_group.wide_rg.name
    location                = azurerm_resource_group.wide_rg.location
    sku                     = "Basic"
    admin_enabled           = false
  
}