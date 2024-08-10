resource "doppler_project" "this" {
  name        = "${var.platform}-${var.service}"
  description = var.description
}

resource "doppler_environment" "this" {
  for_each = var.landscapes
  project  = doppler_project.this.name
  slug     = each.key
  name     = each.value
}

resource "doppler_service_token" "this" {
  for_each = var.store_service_token ? var.landscapes : {}
  project  = doppler_project.this.name
  config   = doppler_environment.this[each.key].slug
  name     = "${each.key}-token"
  access   = "read"
}

resource "doppler_secret" "service_tokens" {
  for_each = var.store_service_token ? var.landscapes : {}
  project  = var.sos_project
  config   = each.key
  name     = "${upper(var.platform)}_${upper(var.service)}"
  value    = doppler_service_token.this[each.key].key
}