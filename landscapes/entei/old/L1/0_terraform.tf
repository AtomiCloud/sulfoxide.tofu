terraform {

  backend "remote" {
    organization = "Atomi-Cloud"

    workspaces {
      name = "entei-l1"
    }
  }

  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.30"
    }
    neon = {
      source  = "kislerdm/neon"
      version = "~> 0.2"
    }
    doppler = {
      source  = "DopplerHQ/doppler"
      version = "~> 1.3"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.11"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.23"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.15"
    }
  }
}
