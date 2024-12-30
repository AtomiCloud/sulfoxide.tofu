module "secret_of_secrets" {
  source = "../../modules/L0/secrets/infisical"

  landscapes = {
    (local.landscapes.suicune.slug) = local.landscapes.suicune.name
    (local.landscapes.entei.slug)   = local.landscapes.entei.name
    (local.landscapes.arceus.slug)  = local.landscapes.arceus.name

    (local.landscapes.absol.slug)  = local.landscapes.absol.name
    (local.landscapes.pinsir.slug) = local.landscapes.pinsir.name
    (local.landscapes.lapras.slug) = local.landscapes.lapras.name
    (local.landscapes.tauros.slug) = local.landscapes.tauros.name

    (local.landscapes.pichu.slug)   = local.landscapes.pichu.name
    (local.landscapes.pikachu.slug) = local.landscapes.pikachu.name
    (local.landscapes.raichu.slug)  = local.landscapes.raichu.name
  }
  platform = local.platforms.sulfoxide.slug
  service  = local.platforms.sulfoxide.services.sos.slug

  description = local.platforms.sulfoxide.services.sos.name
  sos_project = "${local.platforms.sulfoxide.slug}-${local.platforms.sulfoxide.services.sos.slug}"

  store_service_token = true

  infisical_org_id = local.infisical_org_id
}

