resource "infisical_project" "this" {
  name = "${title(var.platform)} ${title(var.service)}"
  slug = "${var.platform}-${var.service}"
}

resource "infisical_project_environment" "this" {
  for_each = var.landscapes

  project_id = infisical_project.this.id
  slug       = each.key
  name       = each.value
}

data "infisical_projects" "sos_project" {
  depends_on = [infisical_project.this]
  count = var.store_service_token ? 1 : 0
  slug  = var.sos_project
}

# temporary
resource "infisical_project_identity" "this" {
  project_id  = infisical_project.this.id
  identity_id = "95ef06f0-6f67-4ac8-85b5-b7cd9dfd101b"
  roles = [
    {
      role_slug = "viewer"
    }
  ]
}

resource "infisical_project_identity_specific_privilege" "this" {
  for_each = var.store_service_token ? var.landscapes : {}

  project_slug = infisical_project.this.slug
  identity_id  = infisical_project_identity.this.identity_id
  permission = {
    actions = ["read"]
    subject = "secrets",
    conditions = {
      environment = each.key
      secret_path = "/"
    }
  }
}

data "infisical_secrets" "token" {
  count        = var.store_service_token ? 1 : 0
  env_slug     = "arceus"
  workspace_id = "32992bde-d1bc-46b3-88ae-5b3279943ae6"
  folder_path  = "/"
}


# secrets

resource "infisical_secret" "id" {
  for_each     = var.store_service_token ? var.landscapes : {}
  name         = "${upper(var.platform)}_${upper(var.service)}_CLIENT_ID"
  value        = split(":", data.infisical_secrets.token[0].secrets["TEMP_SOS_TOKEN"].value)[0]
  env_slug     = each.key
  workspace_id = data.infisical_projects.sos_project[0].id
  folder_path  = "/"
}

resource "infisical_secret" "secret" {
  for_each     = var.store_service_token ? var.landscapes : {}
  name         = "${upper(var.platform)}_${upper(var.service)}_CLIENT_SECRET"
  value        = split(":", data.infisical_secrets.token[0].secrets["TEMP_SOS_TOKEN"].value)[1]
  env_slug     = each.key
  workspace_id = data.infisical_projects.sos_project[0].id
  folder_path  = "/"
}


# resource "doppler_service_token" "this" {
#   for_each = var.store_service_token ? var.landscapes : {}
#   project  = doppler_project.this.name
#   config   = doppler_environment.this[each.key].slug
#   name     = "${each.key}-token"
#   access   = "read"
# }
#
# resource "doppler_secret" "service_tokens" {
#   for_each = var.store_service_token ? var.landscapes : {}
#   project  = var.sos_project
#   config   = each.key
#   name     = "${upper(var.platform)}_${upper(var.service)}"
#   value    = doppler_service_token.this[each.key].key
# }