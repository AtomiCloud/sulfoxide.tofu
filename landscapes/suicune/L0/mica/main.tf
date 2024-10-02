###############
# 01 Provider #
###############

provider "vultr" {
  api_key = data.infisical_secrets.sulfoxide_tofu.secrets["${upper(local.cluster)}_VULTR_TOKEN"].value
}

##############
# 02 Cluster #
##############

module "cluster" {

  source = "../../../../modules/L0/clusters/vultr_cluster"

  landscape     = local.landscape
  cluster       = local.cluster

  k8s_version   = local.k8s_version
  region        = local.regions.vultr
  instance_type = local.instance_type

  max_nodes     = local.max_nodes
  min_nodes     = local.min_nodes

}

#####################
# 03 Cluster Access #
#####################

module "kubeconfig" {

  source = "../../../../modules/L0/connector_secret/infisical"

  landscape    = local.landscape
  project_name = "kubernetes-access"
  secret_name  = "${upper(local.cluster)}_KUBECONFIG"

  name   = module.cluster.name
  server = module.cluster.server
  config = module.cluster.config

}

// For ArgoCD to use
module "kubeconfig_helium" {

  // Admin clusters
  for_each = local.infisical_landscapes.a

  source = "../../../../modules/L0/connector_secret/infisical"

  landscape = each.key

  project_name = "${local.platforms.sulfoxide.slug}-${local.platforms.sulfoxide.services.argocd.slug}"
  secret_name  = "${upper(local.landscape)}_${upper(local.cluster)}_KUBECONFIG"

  name   = module.cluster.name
  server = module.cluster.server
  config = module.cluster.config

}

