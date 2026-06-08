# Populates the variables with concrete values

location = "germanywestcentral"

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
  azurerm_postgresql_flexible_server_movies     = "hp-psql-movies-prod" 
  azurerm_service_plan_backoffice_client        = "hp-asp-backoffice-client"
  azurerm_linux_web_app_backoffice_client       = "hp-alwa-backoffice-client"
}

usernames = {
  movies_microservice_database_username = "MauriceDk06"
}


# ⚠️ Security Warning: This is not a good practice but for this project it is acceptable. 
# In a production environment you should only allow the ip’s that need access to the database.
# Because we don’t know all the Howest ip ranges we will allow all ip’s.
howestprime_allowed_ip_ranges = [
  {
    name             = "allow_all"
    start_ip_address = "0.0.0.0"
    end_ip_address   = "255.255.255.255"
  }
]

github_movies_repository_name = "st-infrastructure-prod-Maurice-De-Kegel"