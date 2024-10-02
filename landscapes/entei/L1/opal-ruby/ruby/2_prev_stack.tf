data "terraform_remote_state" "L0" {
  backend = "pg"

  config = {
    conn_str    = var.tofu_backend
    schema_name = "${local.landscape}-l0-${local.cluster}"
  }
}


locals {
  prev = {
    name   = data.terraform_remote_state.L0.outputs.cluster_name
    server = data.terraform_remote_state.L0.outputs.cluster_server
    config = jsondecode(data.terraform_remote_state.L0.outputs.cluster_config)
  }
}

provider "helm" {

  kubernetes {
    host  = local.prev.server
    cluster_ca_certificate = base64decode(local.prev.config.tlsClientConfig.caData)
    token = local.prev.config.bearerToken
  }
}

provider "kubernetes" {
  host  = local.prev.server
  cluster_ca_certificate = base64decode(local.prev.config.tlsClientConfig.caData)
  token = local.prev.config.bearerToken
}