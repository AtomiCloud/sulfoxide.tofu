###############
# 01 provider #
###############

provider "digitalocean" {
  alias = "opal"
  token = data.doppler_secrets.sulfoxide_terraform.map.OPAL_DIGITALOCEAN_TOKEN
}

##############
# 02 cluster #
##############

module "cluster_opal" {

  source = "../../../modules/L0/digital_ocean_cluster"

  providers = {
    digitalocean = digitalocean.opal
  }

  cluster       = local.clusters.opal
  k8s_version   = local.k8s_version
  instance_type = local.instance_type
  landscape     = local.landscape
  max_nodes     = local.max_nodes
  min_nodes     = local.min_nodes
  region        = local.digital_ocean_region

}

#####################
# 03 cluster access #
#####################

module "kubeconfig_opal" {

  source = "../../../modules/L0/connector_secret"

  landscape    = local.landscape
  project_name = "kubernetes-access"
  secret_name  = "OPAL_KUBECONFIG"

  name   = module.cluster_opal.name
  config = module.cluster_opal.config
  server = module.cluster_opal.server

}

// For ArgoCD to use
module "kubeconfig_opal_helium" {

  // Admin clusters
  for_each = local.doppler_landscapes.a

  source = "../../../modules/L0/connector_secret"

  landscape = each.key

  project_name = "${local.platforms.sulfoxide.slug}-${local.platforms.sulfoxide.services.argocd.slug}"
  secret_name  = "${upper(local.landscape)}_OPAL_KUBECONFIG"

  name   = module.cluster_opal.name
  config = module.cluster_opal.config
  server = module.cluster_opal.server

}

#############
# 04 Output #
#############

output "opal_cluster_id" {
  value = module.cluster_opal.id
}

output "opal_cluster_endpoint" {
  value = module.cluster_opal.endpoint
}

output "opal_cluster_config" {
  value     = module.cluster_opal.kube_config
  sensitive = true
}
