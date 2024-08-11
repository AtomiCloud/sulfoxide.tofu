
module "reference_sos_client_id" {
  depends_on = [
    module.secret_of_secrets,
  ]
  source = "../../modules/L0/sos_reference/infisical"

  project = module.secret_of_secrets.slug
  secret  = "SULFOXIDE_SOS_CLIENT_ID"

  physical_landscapes = local.infisical_landscapes.p
  virtual_landscapes = local.infisical_landscapes.v
}

module "reference_sos_client_secret" {
  depends_on = [
    module.secret_of_secrets,
  ]
  source = "../../modules/L0/sos_reference/infisical"

  project = module.secret_of_secrets.slug
  secret  = "SULFOXIDE_SOS_CLIENT_SECRET"

  physical_landscapes = local.infisical_landscapes.p
  virtual_landscapes = local.infisical_landscapes.v
}