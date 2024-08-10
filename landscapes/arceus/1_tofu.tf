terraform {

  backend "pg" {
    conn_str = var.tofu_backend
    schema_name = "arceus"
  }

  required_providers {
    infisical = {
      source = "Infisical/infisical"
      version = "~> 0"
    }
  }
}
