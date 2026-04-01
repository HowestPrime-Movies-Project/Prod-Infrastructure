resource "azurerm_key_vault" "howestprime_wide_kv" {
    name                                = var.resource_names.azurerm_key_vault_howestprime
    location                            = azurerm_resource_group.wide_rg.location

    tenant_id                           = var.howestprime_tenant_id
    resource_group_name                 = azurerm_resource_group.wide_rg.name
    sku_name                            = "standard"

    soft_delete_retention_days          = 7
    purge_protection_enabled            = false
    enabled_for_disk_encryption         = true      # Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys
    enabled_for_deployment              = true      # retrieve certificates stored as secrets from the key vault
    enabled_for_template_deployment     = true      # retrieve secrets from the key vault.
    rbac_authorization_enabled          = true      # Enables role based authorization

}

resource "azurerm_role_assignment" "terraform_kv_admin" {
    scope                       = azurerm_key_vault.howestprime_wide_kv.id
    role_definition_name        = "Key Vault Administrator"
    principal_id                = var.service_principal_terraform_sp_id

    depends_on                  = [azurerm_key_vault.howestprime_wide_kv]
}

resource "azurerm_role_assignment" "terraform_kv_secrets_officer" {
    scope                       = azurerm_key_vault.howestprime_wide_kv.id
    principal_id                = azurerm_user_assigned_identity.managed_identity.principal_id
    role_definition_name        = "Key Vault Secrets Officer"

    depends_on                  = [azurerm_key_vault.howestprime_wide_kv]
  
}

resource "azurerm_key_vault_secret" "cloudamqp_password" {
  name                          = "message-broker-password"
  value                         = data.cloudamqp_credentials.credentials.password
  key_vault_id                  = azurerm_key_vault.howestprime_wide_kv.id
  depends_on                    = [azurerm_role_assignment.terraform_kv_admin]
}