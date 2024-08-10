data "cloudflare_api_token_permission_groups" "all" {}



resource "cloudflare_api_token" "this" {
  name = local.lpsm

  policy {
    permission_groups = [
      data.cloudflare_api_token_permission_groups.all.account["Workers R2 Storage Write"],
      data.cloudflare_api_token_permission_groups.all.account["Workers R2 Storage Read"],
    ]

    resources = {
      "com.cloudflare.edge.r2.bucket.${var.cf_account_id}_default_${cloudflare_r2_bucket.main.name}" = "*"
    }
  }
}
