locals {
  prefix = "${title(local.landscape)} ${title(local.clusters.digital_ocean.set)}"
}

module "ingress" {
  source = "../../../../modules/L1/cloudflare_zerotrust_tunnel"

  cloudflare_account_id              = local.cloudflare.account_id
  cloudflare_zone                    = local.cloudflare.zone
  cloudflare_gateway_posture_rule_id = local.cloudflare.warp_policy_id

  landscape = local.landscape
  cluster   = local.clusters.digital_ocean.set

  tunnel_ingress_rules = [
    {
      name                 = "ArgoCD"
      dns                  = "deploy"
      session              = "24h"
      app_launcher_visible = true
      logo_url             = "https://icon.icepanel.io/Technology/svg/Argo-CD.svg"
      idp                  = ["saml"]

      path    = "/*"
      service = "http://sulfoxide-helium-argocd-server.sulfoxide-helium.svc.cluster.local:443"

      warp          = true
      email_domains = ["atomi.cloud"]
      saml_groups   = ["engineer", "verified"]
      countries     = ["SG", "MY", "US"]

      bypass_everyone = false
      bypass_ips      = []
    }
  ]
}


data "infisical_projects" "ingress_argocd" {
  slug = "${local.platforms.sulfoxide.slug}-${local.platforms.sulfoxide.services.argocd.slug}"
}

resource "infisical_secret" "ingress_argocd" {

  workspace_id = data.infisical_projects.ingress_argocd.id

  env_slug  = local.landscape
  folder_path = "/"

  name    = "INGRESS_TOKEN"
  value   = module.ingress.tunnel_token

}

data "infisical_projects" "ingress" {
  slug = "${local.platforms.sulfoxide.slug}-${local.platforms.sulfoxide.services.internal_ingress.slug}"
}

resource "infisical_secret" "ingress" {

  workspace_id = data.infisical_projects.ingress.id

  env_slug  = local.landscape
  folder_path = "/"

  name    = "INGRESS_TOKEN"
  value   = module.ingress.tunnel_token
}