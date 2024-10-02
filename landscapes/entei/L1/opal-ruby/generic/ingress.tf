module "internal_ingress" {
  source = "../../../../../modules/L1/cloudflare_zerotrust_tunnel"

  cluster   = local.cluster_set
  landscape = local.landscape

  cloudflare_account_id              = local.cloudflare.account_id
  cloudflare_gateway_posture_rule_id = local.cloudflare.warp_policy_id
  cloudflare_zone                    = local.cloudflare.zone

  tunnel_ingress_rules = [
    {
      name                 = "${title(local.landscape)}  ${title(join(" ",split("-", local.cluster_set)))} Kyverno"
      dns                  = "policy.${local.cluster_set}.${local.landscape}"
      session              = "24h"
      app_launcher_visible = true
      logo_url             = "https://filedn.com/lAUN9W0B3KkXmthALz49m0k/dashboard/kyverno.svg"
      idp = ["saml"]

      path    = "/*"
      service = "http://entei-argon-ui.sulfoxide.svc.cluster.local:8080"

      warp = true
      email_domains = ["atomi.cloud"]
      saml_groups = ["engineer", "verified"]
      countries = ["SG", "MY", "US"]

      bypass_everyone = false
      bypass_ips = []
    }
  ]
}

data "infisical_projects" "ingress" {
  slug = "${local.platforms.sulfoxide.slug}-${local.platforms.sulfoxide.services.internal_ingress.slug}"
}


resource "infisical_secret" "ingress" {
  name  = "${upper(join("_",split("-",local.cluster_set)))}_INGRESS_TOKEN"
  value = module.internal_ingress.tunnel_token

  env_slug     = local.landscape
  folder_path  = "/"
  workspace_id = data.infisical_projects.ingress.id
}