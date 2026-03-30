# Main file, contains the entry point for the Terraform code

terraform {
  required_version = ">=1.14.5"
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = ">=4.61.0"
    }
  }
}

provider "azurerm" {
    features {}
    subscription_id = var.howestprime_subscription_id
    tenant_id       = var.howestprime_tenant_id
  
}