data "doppler_secrets" "sulfoxide_sos" {
  config  = local.landscapes.entei.slug
  project = "${local.platforms.sulfoxide.slug}-${local.platforms.sulfoxide.services.sos.slug}"
}
