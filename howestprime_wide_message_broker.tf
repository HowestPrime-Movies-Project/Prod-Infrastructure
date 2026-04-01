resource "cloudamqp_instance" "howestprime_wide_mb" {
    name      =  var.resource_names.cloudamqp_message_broker
    plan      = "lemming"
    region    = "amazon-web-services::eu-west-1"
}

data "cloudamqp_credentials" "credentials" {
  instance_id = cloudamqp_instance.howestprime_wide_mb.id
}