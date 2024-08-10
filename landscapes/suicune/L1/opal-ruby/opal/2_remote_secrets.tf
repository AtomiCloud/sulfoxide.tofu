provider "infisical" {
  host          = "https://secrets.atomi.cloud"
  client_id     = var.infisical_client_id
  client_secret = var.infisical_client_secret
}

data "infisical_projects" "sulfoxide_sos" {
  slug  = local.sos_project
}

data "infisical_secrets" "sulfoxide_sos" {
  env_slug     = local.landscape
  workspace_id = data.infisical_projects.sulfoxide_sos.id
  folder_path  = "/"
}


