resource "random_password" "db_password" {
    length = 16
    special = true
    override_special = "_%@"
}

resource "azurerm_postgresql_flexible_server" "db_server" {
    name                = var.resource_names.azurerm_postgresql_flexible_server_movies
    location            = azurerm_resource_group.wide_rg.location
    resource_group_name = azurerm_resource_group.wide_rg.name

    administrator_login     = var.usernames.movies_microservice_database_username
    administrator_password  = random_password.db_password.result

    version = 13

    sku_name    = "B_Standard_B1ms"
    storage_mb  = 32768

    backup_retention_days           = 7
    public_network_access_enabled   = true

    lifecycle {
      ignore_changes = [ zone ]
    }
}

resource "azurerm_postgresql_flexible_server_database" "movies_database" {
    server_id = azurerm_postgresql_flexible_server.db_server.id
    name = "movies"
    charset = "UTF8"
    depends_on = [ azurerm_postgresql_flexible_server.db_server ]
  
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "allow_ranges" {
    for_each =  { for rule in var.howestprime_allowed_ip_ranges : rule.name => rule }

    name = each.value.name
    server_id           = azurerm_postgresql_flexible_server.db_server.id
    start_ip_address    = each.value.start_ip_address
    end_ip_address      = each.value.end_ip_address

    depends_on = [ azurerm_postgresql_flexible_server.db_server ]
}

resource "azurerm_key_vault_secret" "generated_password" {
    name = "movies-db-password"
    value = random_password.db_password.result
    key_vault_id = azurerm_key_vault.howestprime_wide_kv.id
    depends_on = [ 
        azurerm_postgresql_flexible_server.db_server, 
        azurerm_postgresql_flexible_server_database.movies_database 
    ]
  
}

locals {
  howestprime_repo_movies = var.github_movies_repository_name
  dotnet_connection_string = format(
    "Server=%s;Database=movies;Port=%s;User Id={username};Password={password};Ssl Mode=Require;",
    azurerm_postgresql_flexible_server.db_server.fqdn,
    5432
  )

  messagebroker_password_uri = regex("(https://[^/]+/secrets/[^/]+)", 
    azurerm_key_vault_secret.cloudamqp_password.id)[0]

  psql_password_uri = regex("(https://[^/]+/secrets/[^/]+)", 
    azurerm_key_vault_secret.generated_password.id)[0]

  howestprime-movies-gh-action-variables = {
    howestprime_movies_p_plsql_login = {
      variable_name = "howestprime_movies_p_psql_login"
      value         = var.usernames.movies_microservice_database_username
    }
    howestprime_movies_p_plslq_connection_string = {
      variable_name = "howestprime_movies_p_psql_connection_string"
      value         = local.dotnet_connection_string
    }
    howestprime_wide_messagebroker_login = {
      variable_name = "howestprime_wide_p_messagebroker_login"
      value         = data.cloudamqp_credentials.credentials.username
    }
    howestprime_wide_keyvault_uri = {
      variable_name = "howestprime_wide_p_keyvault_uri"
      value         = azurerm_key_vault.howestprime_wide_kv.vault_uri
    }
    howestprime_wide_mi_keyvaultreader_uri = {
      variable_name = "howestprime_wide_mi_keyvaultreader_uri"
      value         = azurerm_user_assigned_identity.managed_identity.id
    }
    az_tenant_id = {
      variable_name = "az_tenant_id"
      value         = var.howestprime_tenant_id
    }
    az_subscription_id = {
      variable_name = "az_subscription_id"
      value         = var.howestprime_subscription_id
    }
    az_resource_group = {
      variable_name = "az_resource_group"
      value         = azurerm_resource_group.wide_rg.name
    }
    az_container_registry = {
      variable_name = "az_container_registry"
      value         = azurerm_container_registry.howestprime_wide_cr.login_server
    }
    az_container_environment = {
      variable_name = "az_container_environment"
      value         = azurerm_container_app_environment.howestprime_wide_ce.name
    }
    howestprime_movies_p_sqlsrv_password_uri = {
      variable_name = "howestprime_movies_p_sqlsrv_password_uri"
      value         = local.psql_password_uri
    }
    howestprime_wide_p_messagebroker_password_uri = {
      variable_name = "howestprime_wide_p_messagebroker_password_uri"
      value         = local.messagebroker_password_uri
    }
    howestprime_wide_p_messagebroker_uri = {
      variable_name = "howestprime_wide_p_messagebroker_hostname"
      value         = cloudamqp_instance.howestprime_wide_mb.host
    }
    howestprime_wide_p_messagebroker_vhost = {
      variable_name = "howestprime_wide_p_messagebroker_vhost"
      value         = cloudamqp_instance.howestprime_wide_mb.vhost
    }
  }
  
  howestprime-movies-gh-action-secrets = {
    howestprime_wide_ci_service_principal = {
      secret_name = "howestprime_wide_ci_service_principal"
      value       = azuread_application.github_cicd.client_id
    }
    howestprime_wide_ci_service_principal_password = {
      secret_name = "howestprime_wide_ci_service_principal_password"
      value       = azuread_application_password.github_cicd.value
    }
  }
}

resource "github_actions_variable" "howestprime_movies" {
  for_each      = local.howestprime-movies-gh-action-variables
  repository    = local.howestprime_repo_movies
  variable_name = each.value.variable_name
  value         = each.value.value
}

resource "github_actions_secret" "howestprime_movies" {
  for_each      = local.howestprime-movies-gh-action-secrets
  repository    = local.howestprime_repo_movies
  secret_name   = each.value.secret_name
  plaintext_value = each.value.value
}
