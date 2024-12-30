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


resource "infisical_identity" "this" {
  for_each = var.store_service_token ? var.landscapes : {}
  name   = "${each.key}-${var.platform}-${var.service}"
  role   = "member"
  org_id = var.infisical_org_id
}

resource "infisical_project_identity" "this" {
  for_each = var.store_service_token ? var.landscapes : {}
  project_id  = infisical_project.this.id
  identity_id = infisical_identity.this[each.key].id
  roles = [
    {
      role_slug = "viewer"
    }
  ]
}

resource "infisical_project_identity_specific_privilege" "this" {
  for_each = var.store_service_token ? var.landscapes : {}

  project_slug = infisical_project.this.slug
  identity_id  = infisical_project_identity.this[each.key].identity_id
  permission = {
    actions = ["read"]
    subject = "secrets",
    conditions = {
      environment = each.key
      secret_path = "/"
    }
  }
}

resource "infisical_identity_universal_auth" "this" {
  for_each = var.store_service_token ? var.landscapes : {}
  identity_id = infisical_project_identity.this[each.key].identity_id
}

resource "infisical_identity_universal_auth_client_secret" "this" {
  depends_on = [infisical_identity_universal_auth.this]
  for_each = var.store_service_token ? var.landscapes : {}
  identity_id = infisical_project_identity.this[each.key].identity_id
  description = "Universal Auth Client Secret for ${each.key}"
}

# data "infisical_secrets" "token" {
#   count        = var.store_service_token ? 1 : 0
#   env_slug     = "arceus"
#   workspace_id = "32992bde-d1bc-46b3-88ae-5b3279943ae6"
#   folder_path  = "/"
# }
#

# secrets
data "infisical_projects" "sos_project" {
  depends_on = [infisical_project.this]
  count = var.store_service_token ? 1 : 0
  slug  = var.sos_project
}

resource "infisical_secret" "id" {
  for_each     = var.store_service_token ? var.landscapes : {}
  name         = "${upper(var.platform)}_${upper(var.service)}_CLIENT_ID"
  value        = infisical_identity_universal_auth_client_secret.this[each.key].client_id
  env_slug     = each.key
  workspace_id = data.infisical_projects.sos_project[0].id
  folder_path  = "/"
}

resource "infisical_secret" "secret" {
  for_each     = var.store_service_token ? var.landscapes : {}
  name         = "${upper(var.platform)}_${upper(var.service)}_CLIENT_SECRET"
  value        = infisical_identity_universal_auth_client_secret.this[each.key].client_secret
  env_slug     = each.key
  workspace_id = data.infisical_projects.sos_project[0].id
  folder_path  = "/"
}