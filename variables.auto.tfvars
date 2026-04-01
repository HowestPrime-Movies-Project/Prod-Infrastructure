# Populates the variables with concrete values

location = "swedencentral"

# Example
# mapKey = the identifier of the resource in the Terraform code
# mapValue = the name of the resource in Azure
resource_names = {
  azurerm_resource_group_howestprime            = "howestprime-wide-p-arg"
  azurerm_key_vault_howestprime                 = "hp-kv-azure-is-fun"
  azurerm_container_registry_howestprime        = "howestprimewidepcr"
  cloudamqp_message_broker                      = "howestprime-message-broker"
  azurerm_log_analytics                         = "howestprime-logger"
  azurerm_container_environment                 = "howestprime-container-environment"
  azurerm_managed_identity                      = "mi-howestprime-prod-github-cicd"
}
