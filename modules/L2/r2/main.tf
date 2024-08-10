resource "cloudflare_r2_bucket" "main" {
  account_id = var.cf_account_id
  name       = local.lpsm
  location   = var.cf_region
}

