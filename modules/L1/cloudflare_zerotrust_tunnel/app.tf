module "applications" {

  count = length(var.tunnel_ingress_rules)

  source = "../cloudflare_zerotrust_application"

  # cloudflare config
  cloudflare_account_id              = var.cloudflare_account_id
  cloudflare_zone                    = var.cloudflare_zone
  cloudflare_gateway_posture_rule_id = var.cloudflare_gateway_posture_rule_id

  # service tree
  cluster   = var.cluster
  landscape = var.landscape

  name                 = var.tunnel_ingress_rules[count.index].name
  hostname             = cloudflare_record.zerotrust_record[count.index].hostname
  session              = var.tunnel_ingress_rules[count.index].session
  app_launcher_visible = var.tunnel_ingress_rules[count.index].app_launcher_visible
  logo_url             = var.tunnel_ingress_rules[count.index].logo_url
  idp                  = var.tunnel_ingress_rules[count.index].idp

  warp          = var.tunnel_ingress_rules[count.index].warp
  email_domains = var.tunnel_ingress_rules[count.index].email_domains
  saml_groups   = var.tunnel_ingress_rules[count.index].saml_groups
  countries     = var.tunnel_ingress_rules[count.index].countries

  bypass_everyone = var.tunnel_ingress_rules[count.index].bypass_everyone
  bypass_ips      = var.tunnel_ingress_rules[count.index].bypass_ips
}
