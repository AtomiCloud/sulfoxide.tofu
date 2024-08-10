resource "cloudflare_access_policy" "block_countries" {

  count = (length(var.countries) > 0) ? 1 : 0

  zone_id        = data.cloudflare_zone.zone.id
  application_id = cloudflare_access_application.zerotrust_app.id
  decision       = "deny"
  name           = "${var.name} Block Countries"
  precedence     = 1

  include {
    everyone = true
  }

  exclude {
    geo = var.countries
  }
}

resource "cloudflare_access_policy" "block_saml_groups" {

  count = (length(var.saml_groups) > 0) ? 1 : 0

  zone_id        = data.cloudflare_zone.zone.id
  application_id = cloudflare_access_application.zerotrust_app.id
  decision       = "deny"
  name           = "${var.name} Block Groups"
  precedence     = 2

  include {
    everyone = true
  }

  dynamic "exclude" {
    for_each = var.saml_groups
    content {
      saml {
        identity_provider_id = local.idp.saml
        attribute_name       = "groups"
        attribute_value      = exclude.value
      }
    }
  }
}



resource "cloudflare_access_policy" "allow_policy" {

  zone_id        = data.cloudflare_zone.zone.id
  application_id = cloudflare_access_application.zerotrust_app.id
  decision       = "allow"
  name           = "${var.name} Allow Policy"
  precedence     = 3

  include {
    email_domain = var.email_domains
  }

  require {
    device_posture = [
      var.cloudflare_gateway_posture_rule_id
    ]
  }
}

resource "cloudflare_access_policy" "bypass_policy" {

  count = (var.bypass_everyone || (length(var.bypass_ips) > 0)) ? 1 : 0

  zone_id        = data.cloudflare_zone.zone.id
  application_id = cloudflare_access_application.zerotrust_app.id
  decision       = "bypass"
  name           = "${var.name} Bypass Policy"
  precedence     = 4

  include {
    everyone = var.bypass_everyone == true
    ip       = var.bypass_ips
  }
}


