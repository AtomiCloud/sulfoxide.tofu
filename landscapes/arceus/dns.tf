
data "cloudflare_zone" "this" {
  name = local.cloudflare.zone
}

resource "cloudflare_record" "this" {
  for_each = local.dns_clusters
  zone_id = data.cloudflare_zone.this.id
  name    = "*.${each.value}.kubernetes"
  content   = "${each.value}.lb.${local.cloudflare.zone}"
  type    = "CNAME"
  ttl     = 120
}

resource "cloudflare_record" "lb" {
  zone_id = data.cloudflare_zone.this.id
  name    = "*.cluster"
  content   = "${var.target_cluster}.lb.${local.cloudflare.zone}"
  type    = "CNAME"
  ttl     = 120
}