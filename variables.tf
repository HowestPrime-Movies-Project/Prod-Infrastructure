# Contains the variables used in the Terraform code

variable "howestprime_subscription_id" {
    description = "The azure subscription ID for the Howest Prime environment"
    type        = string
}

variable "howestprime_tenant_id" {
    description = "The azure tenant id"
    type = string
}