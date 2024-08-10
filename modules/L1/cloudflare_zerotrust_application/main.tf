data "cloudflare_zone" "zone" {
  account_id = var.cloudflare_account_id
  name       = var.cloudflare_zone
}

resource "cloudflare_access_application" "zerotrust_app" {

  zone_id                    = data.cloudflare_zone.zone.id
  name                       = var.name
  domain                     = var.hostname
  type                       = "self_hosted"
  session_duration           = var.session
  http_only_cookie_attribute = false
  app_launcher_visible       = var.app_launcher_visible
  logo_url                   = var.logo_url

  allowed_idps = [for i, v in var.idp : local.idp[v]]

  auto_redirect_to_identity = length(var.idp) == 1
}
