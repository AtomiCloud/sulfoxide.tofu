terraform {

  backend "pg" {
    conn_str = var.tofu_backend
    schema_name = "${local.landscape}-l1-${local.cluster_set}"
  }

  required_providers {
    infisical = {
      source  = "Infisical/infisical"
      version = "~> 0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4"
    }
  }
}
