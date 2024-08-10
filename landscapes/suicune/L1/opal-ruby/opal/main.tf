module "external_secrets" {
  source = "../../../../../modules/L1/external_secrets/infisical"

  landscape = local.landscape
  platform  = local.platforms.sulfoxide.slug
  service   = local.platforms.sulfoxide.services.secrets_engine.slug

  root_client_id     = data.infisical_secrets.sulfoxide_sos.secrets["${upper(local.sos_project_snake)}_CLIENT_ID"].value
  root_client_secret = data.infisical_secrets.sulfoxide_sos.secrets["${upper(local.sos_project_snake)}_CLIENT_SECRET"].value
  sos_project        = local.sos_project

  infisical_api = "https://secrets.atomi.cloud"
  path          = "/"

  bump = 0
}
