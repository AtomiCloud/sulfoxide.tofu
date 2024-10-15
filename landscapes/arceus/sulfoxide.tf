module "sulfoxide_tofu_infisical" {
  source = "../../modules/L0/secrets/infisical"

  landscapes = {
    (local.landscapes.suicune.slug) = local.landscapes.suicune.name
    (local.landscapes.entei.slug)   = local.landscapes.entei.name

    (local.landscapes.pichu.slug)   = local.landscapes.pichu.name
    (local.landscapes.pikachu.slug) = local.landscapes.pikachu.name
    (local.landscapes.raichu.slug)  = local.landscapes.raichu.name

    (local.landscapes.arceus.slug) = local.landscapes.arceus.name
  }
  platform = local.platforms.sulfoxide.slug
  service  = local.platforms.sulfoxide.services.tofu.slug

  description = "Sulfoxide Tofu holds secrets for tofu that controls the whole AtomiCloud infrastructure"
  sos_project = local.sos_project

  store_service_token = true
}

# ArgoCD
module "sulfoxide_helium_infisical" {
  source = "../../modules/L0/secrets/infisical"

  landscapes = merge(local.infisical_landscapes.a)
  platform   = local.platforms.sulfoxide.slug
  service    = local.platforms.sulfoxide.services.argocd.slug

  description = "Secrets for ${local.platforms.sulfoxide.services.argocd.description}"
  sos_project = local.sos_project

  store_service_token = true
}

# Internal Ingress
module "sulfoxide_boron_infisical" {
  source = "../../modules/L0/secrets/infisical"

  landscapes = merge(local.infisical_landscapes.a, local.infisical_landscapes.v, local.infisical_landscapes.p)
  platform   = local.platforms.sulfoxide.slug
  service    = local.platforms.sulfoxide.services.internal_ingress.slug

  description = "Secrets for ${local.platforms.sulfoxide.services.internal_ingress.description}"
  sos_project = local.sos_project

  store_service_token = true
}

# External Ingress
module "sulfoxide_oxygen_infisical" {
  source = "../../modules/L0/secrets/infisical"

  landscapes = merge(local.infisical_landscapes.p)
  platform   = local.platforms.sulfoxide.slug
  service    = local.platforms.sulfoxide.services.external_ingress.slug

  description = "Secrets for ${local.platforms.sulfoxide.services.external_ingress.description}"
  sos_project = local.sos_project

  store_service_token = true
}

# Pod Autoscaler KEDA
module "sulfoxide_iron_infisical" {
  source = "../../modules/L0/secrets/infisical"

  landscapes = merge(local.infisical_landscapes.v)
  platform   = local.platforms.sulfoxide.slug
  service    = local.platforms.sulfoxide.services.scaler.slug

  description = "Secrets for ${local.platforms.sulfoxide.services.scaler.description}"
  sos_project = local.sos_project

  store_service_token = true
}

# Policy Engine
module "sulfoxide_argon_infisical" {
  source = "../../modules/L0/secrets/infisical"

  landscapes = merge(local.infisical_landscapes.v)
  platform   = local.platforms.sulfoxide.slug
  service    = local.platforms.sulfoxide.services.policy_engine.slug

  description = "Secrets for ${local.platforms.sulfoxide.services.policy_engine.description}"
  sos_project = local.sos_project

  store_service_token = true
}

# Policies
module "sulfoxide_sodium_infisical" {
  source = "../../modules/L0/secrets/infisical"

  landscapes = merge(local.infisical_landscapes.v)
  platform   = local.platforms.sulfoxide.slug
  service    = local.platforms.sulfoxide.services.policies.slug

  description = "Secrets for ${local.platforms.sulfoxide.services.policies.description}"
  sos_project = local.sos_project

  store_service_token = true
}

# Cert Manager
module "sulfoxide_sulfur_infisical" {
  source = "../../modules/L0/secrets/infisical"

  landscapes = merge(local.infisical_landscapes.v, local.infisical_landscapes.p)
  platform   = local.platforms.sulfoxide.slug
  service    = local.platforms.sulfoxide.services.cert_manager.slug

  description = "Secrets for ${local.platforms.sulfoxide.services.cert_manager.description}"
  sos_project = local.sos_project

  store_service_token = true
}

# Cluster Issuer
module "sulfoxide_zinc_infisical" {
  source = "../../modules/L0/secrets/infisical"

  landscapes = merge(local.infisical_landscapes.v, local.infisical_landscapes.p)
  platform   = local.platforms.sulfoxide.slug
  service    = local.platforms.sulfoxide.services.cluster_issuer.slug

  description = "Secrets for ${local.platforms.sulfoxide.services.cluster_issuer.description}"
  sos_project = local.sos_project

  store_service_token = true
}

# OTEL Operator
module "sulfoxide_lithium_infisical" {
  source = "../../modules/L0/secrets/infisical"

  landscapes = merge(local.infisical_landscapes.v, local.infisical_landscapes.p)
  platform   = local.platforms.sulfoxide.slug
  service    = local.platforms.sulfoxide.services.otel_operator.slug

  description = "Secrets for ${local.platforms.sulfoxide.services.otel_operator.description}"
  sos_project = local.sos_project

  store_service_token = true
}

# OTEL Collector
module "sulfoxide_silicon_infisical" {
  source = "../../modules/L0/secrets/infisical"

  landscapes = merge(local.infisical_landscapes.v, local.infisical_landscapes.p)
  platform   = local.platforms.sulfoxide.slug
  service    = local.platforms.sulfoxide.services.otel_collector.slug

  description = "Secrets for ${local.platforms.sulfoxide.services.otel_collector.description}"
  sos_project = local.sos_project

  store_service_token = true
}

# Backup Engine
module "sulfoxide_fluorine_infisical" {
  source = "../../modules/L0/secrets/infisical"

  landscapes = merge(local.infisical_landscapes.a)
  platform   = local.platforms.sulfoxide.slug
  service    = local.platforms.sulfoxide.services.backup_engine.slug

  description = "Secrets for ${local.platforms.sulfoxide.services.backup_engine.description}"
  sos_project = local.sos_project

  store_service_token = true
}

# Secret Engine
module "sulfoxide_cobalt_infisical" {
  source = "../../modules/L0/secrets/infisical"

  landscapes = merge(local.infisical_landscapes.a, local.infisical_landscapes.v, local.infisical_landscapes.p)
  platform   = local.platforms.sulfoxide.slug
  service    = local.platforms.sulfoxide.services.secrets_engine.slug

  description = "Secrets for ${local.platforms.sulfoxide.services.secrets_engine.description}"
  sos_project = local.sos_project

  store_service_token = true
}

# External DNS
module "sulfoxide_tin_infisical" {
  source = "../../modules/L0/secrets/infisical"

  landscapes = merge(local.infisical_landscapes.p)
  platform   = local.platforms.sulfoxide.slug
  service    = local.platforms.sulfoxide.services.external_dns.slug

  description = "Secrets for ${local.platforms.sulfoxide.services.external_dns.description}"
  sos_project = local.sos_project

  store_service_token = true
}

# Virtual Cluster
module "sulfoxide_iodine_infisical" {
  source = "../../modules/L0/secrets/infisical"

  landscapes = merge(local.infisical_landscapes.p)
  platform   = local.platforms.sulfoxide.slug
  service    = local.platforms.sulfoxide.services.vcluster.slug

  description = "Secrets for ${local.platforms.sulfoxide.services.vcluster.description}"
  sos_project = local.sos_project

  store_service_token = true
}

# Victoria Metrics
module "sulfoxide_gallium_infisical" {
  source = "../../modules/L0/secrets/infisical"

  landscapes = merge(local.infisical_landscapes.a)
  platform   = local.platforms.sulfoxide.slug
  service    = local.platforms.sulfoxide.services.metrics_engine.slug

  description = "Secrets for ${local.platforms.sulfoxide.services.metrics_engine.description}"
  sos_project = local.sos_project

  store_service_token = true
}