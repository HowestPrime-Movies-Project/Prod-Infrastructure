resource "azurerm_container_app_environment" "howestprime_wide_ce" {
    name = var.resource_names.azurerm_container_environment
    location = azurerm_resource_group.wide_rg.location
    resource_group_name = azurerm_resource_group.wide_rg.name
    log_analytics_workspace_id = azurerm_log_analytics_workspace.howestprime.id
}