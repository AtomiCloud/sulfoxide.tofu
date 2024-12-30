module "kubernetes_access_infisical" {
  source = "../../modules/L0/secrets/infisical"

  landscapes = {
    (local.landscapes.suicune.slug) = local.landscapes.suicune.name
    (local.landscapes.entei.slug)   = local.landscapes.entei.name

    (local.landscapes.pichu.slug)   = local.landscapes.pichu.name
    (local.landscapes.pikachu.slug) = local.landscapes.pikachu.name
    (local.landscapes.raichu.slug)  = local.landscapes.raichu.name
  }
  platform = "kubernetes"
  service  = "access"

  description = "Store Admin KubeConfig to access both virtual and real clusters"
  sos_project = local.sos_project

  store_service_token = false

  infisical_org_id = local.infisical_org_id
}