# Main file, contains the entry point for the Terraform code

terraform {
  required_version = ">=1.14.5"
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = ">=4.61.0"
    }
    cloudamqp = {
      source = "cloudamqp/cloudamqp"
      version = "~>1.42"
    }
  }
}


provider "azurerm" {
    features {
      key_vault {
        purge_soft_delete_on_destroy = true
        purge_soft_deleted_secrets_on_destroy = true
      }
    }
    subscription_id = var.howestprime_subscription_id
    tenant_id       = var.howestprime_tenant_id

    client_id = var.service_principal_terraform_client_id
    client_secret = var.service_principal_terraform_secret
  
}

provider "cloudamqp" {
  apikey = var.cloudamqp_full_access_api_key  
}