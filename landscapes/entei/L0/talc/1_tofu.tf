terraform {

  backend "pg" {
    conn_str = var.tofu_backend
    schema_name = "${local.landscape}-l0-${local.cluster}"
  }

  required_providers {
    infisical = {
      source  = "Infisical/infisical"
      version = "~> 0"
    }
    vultr = {
      source  = "vultr/vultr"
      version = ">= 2"
    }
  }
}
