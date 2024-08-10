locals {

  # service tree
  landscape = local.landscapes.entei.slug

  clusters = {
    opal = "opal"
    ruby = "ruby"

    opal_ruby = "opal-ruby"
  }

  # cloudflare
  cf_zone              = "atomi.cloud"
  cf_gateway_policy_id = "274146bb-6ccf-4988-bc61-79a070acbb1a"
  cf_warp_policy_id    = "55971cbe-2ddf-4c30-b504-abbb901a0600"
  cf_region            = "APAC"

}
