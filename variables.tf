# Contains the variables used in the Terraform code

variable "howestprime_subscription_id" {
    description = "The azure subscription ID for the Howest Prime environment"
    type        = string
}

variable "howestprime_tenant_id" {
    description = "The azure tenant id"
    type = string
}

variable "service_principal_terraform_client_id" {
    description = "The Service principal client id"
    type = string
}

variable "service_principal_terraform_secret" {
    description = "The azure service principal secret "
    type = string
}

variable "service_principal_terraform_sp_id" {
    description = "The id"
    type = string
}

variable "location" {
  description = "The location of the azure servers"
  type = string
}

variable "resource_names" {
description = "Map of resource names to assign to the resources."
type        = map(string)
}

variable "cloudamqp_full_access_api_key" {
    description = "CloudAMQP Full Access API Key"
    type        = string
    sensitive   = true
}
