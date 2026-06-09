resource "azurerm_service_plan" "howestprime-web-app" {
  os_type = "Linux"
  sku_name = "F1"
  name = var.resource_names.azurerm_service_plan_client_web_app
  location = azurerm_resource_group.wide_rg.location
  resource_group_name = azurerm_resource_group.wide_rg.name
}

resource "azurerm_linux_web_app" "howestprime-web-app" {
  service_plan_id = azurerm_service_plan.howestprime-web-app.id
  
  site_config {
    always_on = false
    minimum_tls_version = "1.2"
    application_stack {
      docker_image_name = "howestprime-client-webapp:latest"
      docker_registry_url = "https://hcr.technet.howest.be"
    
    }
    cors {
        allowed_origins = [ "*" ]
    
    }
    
  }
  auth_settings {
    enabled = false
  }

  app_settings = {
    DOCKER_REGISTRY_URL = "https://hcr.technet.howest.be"
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    VITE_APP_TICKETING_API_URL = var.vite_app_ticketing_api_url
    VITE_APP_MOVIES_BASE_API_URL = var.vite_app_movies_base_api_url
  }

  resource_group_name = azurerm_resource_group.wide_rg.name
  location = azurerm_resource_group.wide_rg.location
  name = var.resource_names.azurerm_linux_web_app_client_web_app

  
}