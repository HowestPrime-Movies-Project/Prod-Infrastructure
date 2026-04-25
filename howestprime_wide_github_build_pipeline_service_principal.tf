resource "azuread_application" "github_cicd" {
    display_name = "howestprime-prod-github-cicd"
  
}

resource "time_rotating" "github_cicd_secret_rotation" {
  rotation_days = 180
}

resource "azuread_application_password" "github_cicd" {
  application_id = azuread_application.github_cicd.id

  rotate_when_changed = {
    rotation  = time_rotating.github_cicd_secret_rotation.id
  }
}

resource "azuread_service_principal" "github_cicd" {
  client_id   = azuread_application.github_cicd.client_id
  owners      = [ var.service_principal_terraform_sp_id ]
}

resource "azurerm_role_assignment" "container_registry_push_access" {
  role_definition_name = "AcrPush"
  scope = azurerm_container_registry.howestprime_wide_cr.id
  principal_id = azuread_service_principal.github_cicd.object_id
  depends_on = [
    azuread_service_principal.github_cicd,
    azurerm_container_registry.howestprime_wide_cr,
    azurerm_key_vault.howestprime_wide_kv
  ]
  
}

resource "azurerm_role_assignment" "resource_group_management" {
  role_definition_name = "Contributor"
  scope = azurerm_resource_group.wide_rg.id
  principal_id = azuread_service_principal.github_cicd.object_id
  depends_on = [
    azuread_service_principal.github_cicd,
    azurerm_resource_group.wide_rg,
    azurerm_key_vault.howestprime_wide_kv
  ]
}