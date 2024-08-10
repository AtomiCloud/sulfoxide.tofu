provider "doppler" {
  doppler_token = var.doppler_token
}

data "doppler_secrets" "sulfoxide_terraform" {
  config  = local.landscapes.entei.slug
  project = "${local.platforms.sulfoxide.slug}-${local.platforms.sulfoxide.services.terraform.slug}"
}