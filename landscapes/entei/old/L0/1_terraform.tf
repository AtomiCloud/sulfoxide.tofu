terraform {

  backend "remote" {
    organization = "Atomi-Cloud"

    workspaces {
      name = "entei-l0"
    }
  }

  required_providers {
    doppler = {
      source  = "DopplerHQ/doppler"
      version = "~> 1.3"
    }
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.30"
    }
  }
}
