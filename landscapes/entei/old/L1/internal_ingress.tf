module "opal_ruby_ingress" {
  source = "../../../modules/L1/cloudflare_zerotrust_tunnel"

  providers = {
    cloudflare = cloudflare.main
  }

  cloudflare_account_id              = local.cf_account_id
  cloudflare_zone                    = local.cf_zone
  cloudflare_gateway_posture_rule_id = local.cf_warp_policy_id

  landscape = local.landscape
  cluster   = local.clusters.opal_ruby

  tunnel_ingress_rules = [
    {
      name                 = "${title(local.landscape)} Kyverno"
      dns                  = "policy.${local.landscape}"
      session              = "24h"
      app_launcher_visible = true
      logo_url             = "https://filedn.com/lAUN9W0B3KkXmthALz49m0k/dashboard/kyverno.svg"
      idp                  = ["saml"]

      path    = "/*"
      service = "http://entei-argon-ui.sulfoxide.svc.cluster.local:8080"

      warp          = true
      email_domains = ["atomi.cloud"]
      saml_groups   = ["engineer", "verified"]
      countries     = ["SG", "MY", "US"]

      bypass_everyone = false
      bypass_ips      = []
    },
  ]
}

resource "doppler_secret" "opal_ruby_ingress" {
  config  = local.landscape
  name    = "OPAL_RUBY_INGRESS_TOKEN"
  project = "${local.platforms.sulfoxide.slug}-${local.platforms.sulfoxide.services.internal_ingress.slug}"
  value   = module.opal_ruby_ingress.tunnel_token
}