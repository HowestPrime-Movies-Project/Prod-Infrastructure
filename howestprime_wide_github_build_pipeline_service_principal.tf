resource "azuread_application" "github_cicd" {
    display_name = "howestprime-prod-github-cicd"
  
}

resource "time_rotating" "github_cicd_secret_rotation" {
  rotation_days = 180
}

resource "azuread_application_password" "github_cicd" {
  application_id = azuread_application.github_cicd.id

  rotate_when_changed = {
    rotation = time_rotating.github_cicd_secret_rotation.id
  }
}

resource "azuread_service_principal" "github_cicd" {
  client_id = azuread_application.github_cicd.client_id
  owners = [ var.service_principal_terraform_sp_id ]
}