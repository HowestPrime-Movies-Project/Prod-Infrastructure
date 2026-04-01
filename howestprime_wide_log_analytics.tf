resource "azurerm_log_analytics_workspace" "howestprime" {
    resource_group_name = azurerm_resource_group.wide_rg.name
    location = azurerm_resource_group.wide_rg.location
    name = var.resource_names.azurerm_log_analytics
}