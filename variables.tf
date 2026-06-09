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

variable "usernames" {
    description = ""
    type        = map(string)
}

# ⚠️ Security Warning: This is not a good practice but for this project it is acceptable. 
# In a production environment you should only allow the ip’s that need access to the database.
# Because we don’t know all the Howest ip ranges we will allow all ip’s.
variable "howestprime_allowed_ip_ranges" {
  description = "List allowed IP addresses for documentDB firewall rule"
  type = list(object({
    name             = string
    start_ip_address = string
    end_ip_address   = string
  }))
}

variable "github_personal_access_token" {
  description = "A Personal Access Token For GitHub"
  type = string
}

variable "github_organization-or-owner_name" {
  description = "The Github Organization/Owner Name"
  type = string
}

variable "github_movies_repository_name" {
  description = "Repository name for the movies microservice pipeline variables/secrets"
  type        = string
}

variable "vite_app_ticketing_api_url" {
  description = "The API url for ticketing microservice"
  type = string
}

variable "vite_app_movies_base_api_url" {
  description = "The API url for movies microservice"
  type = string
}