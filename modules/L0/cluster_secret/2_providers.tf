locals {
  config = jsondecode(var.config)
}

provider "kubernetes" {
  host                   = var.server
  cluster_ca_certificate = base64decode(local.config.tlsClientConfig.caData)
  token                  = local.config.bearerToken
}