module "velero_backup_r2" {

  source = "../../../../modules/L2/r2"

  cf_account_id = local.cloudflare.account_id
  cf_region     = local.regions.cloudflare
  landscape     = local.landscape
  platform      = local.platforms.sulfoxide.slug
  service       = local.platforms.sulfoxide.services.backup_engine.slug

}

data "infisical_projects" "backup_engine" {
  slug = "${local.platforms.sulfoxide.slug}-${local.platforms.sulfoxide.services.backup_engine.slug}"
}

resource "infisical_secret" "backup_engine_key" {

  workspace_id = data.infisical_projects.backup_engine.id

  env_slug  = local.landscape
  folder_path = "/"

  name    = "AWS_ACCESS_KEY"
  value   = module.velero_backup_r2.key
}

resource "infisical_secret" "backup_engine_secret" {

  workspace_id = data.infisical_projects.backup_engine.id

  env_slug  = local.landscape
  folder_path = "/"

  name    = "AWS_ACCESS_SECRET"
  value   = module.velero_backup_r2.secret
}