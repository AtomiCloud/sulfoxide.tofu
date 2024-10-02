resource "random_id" "tunnel_secret" {
  byte_length = 35
}

data "cloudflare_zone" "zone" {
  account_id = var.cloudflare_account_id
  name       = var.cloudflare_zone
}

resource "cloudflare_tunnel" "zerotrust_tunnel" {
  account_id = var.cloudflare_account_id
  name       = "${var.landscape}-${var.cluster}-tunnel"
  secret     = random_id.tunnel_secret.b64_std
}

// Add DNS Records
resource "cloudflare_record" "zerotrust_record" {
  count = length(var.tunnel_ingress_rules)
  zone_id = data.cloudflare_zone.zone.id

  name    = var.tunnel_ingress_rules[count.index].dns
  content = cloudflare_tunnel.zerotrust_tunnel.cname
  type    = "CNAME"
  proxied = true
}

resource "cloudflare_tunnel_config" "zerotrust_config" {
  account_id = var.cloudflare_account_id
  tunnel_id  = cloudflare_tunnel.zerotrust_tunnel.id

  config {
    warp_routing {
      enabled = true
    }

    origin_request {
      connect_timeout = "1m0s"
    }

    dynamic "ingress_rule" {
      for_each = var.tunnel_ingress_rules

      content {
        hostname = cloudflare_record.zerotrust_record[ingress_rule.key].hostname
        path     = ingress_rule.value.path
        service  = ingress_rule.value.service
      }
    }

    ingress_rule {
      service = var.ingress_fallback
    }
  }
}


