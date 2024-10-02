terraform {

  backend "pg" {
    conn_str = var.tofu_backend
    schema_name = "${local.landscape}-l1-${local.cluster}"
  }

  required_providers {
    infisical = {
      source  = "Infisical/infisical"
      version = "~> 0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~> 2"
    }
    helm = {
      source = "hashicorp/helm"
      version = "~> 2"
    }
  }
}
