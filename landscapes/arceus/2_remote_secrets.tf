data "infisical_projects" "sulfoxide_tofu" {
  slug  = "${local.platforms.sulfoxide.slug}-${local.platforms.sulfoxide.services.tofu.slug}"
}

data "infisical_secrets" "sulfoxide_tofu" {
  env_slug     = local.landscapes.arceus.slug
  workspace_id = data.infisical_projects.sulfoxide_tofu.id
  folder_path  = "/"
}