provider "infisical" {
  host          = "https://secrets.atomi.cloud"
  client_id     = var.infisical_client_id
  client_secret = var.infisical_client_secret
}

data "infisical_projects" "sulfoxide_tofu" {
  slug  = "${local.platforms.sulfoxide.slug}-${local.platforms.sulfoxide.services.tofu.slug}"
}

data "infisical_secrets" "sulfoxide_tofu" {
  env_slug     = local.landscape
  workspace_id = data.infisical_projects.sulfoxide_tofu.id
  folder_path  = "/"
}