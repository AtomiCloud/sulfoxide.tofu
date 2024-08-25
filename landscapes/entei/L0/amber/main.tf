###############
# 01 Provider #
###############

provider "aws" {
  region     = local.regions.aws

  access_key = data.infisical_secrets.sulfoxide_tofu.secrets["${upper(local.cluster)}_AWS_ACCESS_KEY"].value
  secret_key = data.infisical_secrets.sulfoxide_tofu.secrets["${upper(local.cluster)}_AWS_SECRET_KEY"].value
}

##############
# 02 Cluster #
##############

module "cluster" {

  source = "../../../../modules/L0/clusters/eks_cluster"


  landscape = local.landscape
  cluster   = local.cluster

  access_key = data.infisical_secrets.sulfoxide_tofu.secrets["${upper(local.cluster)}_AWS_ACCESS_KEY"].value
  secret_key = data.infisical_secrets.sulfoxide_tofu.secrets["${upper(local.cluster)}_AWS_SECRET_KEY"].value

  cidr                      = local.cidr
  ips                       = 3
  k8s_version               = local.k8s_version
  karpenter_service_account = local.platforms.sulfoxide.services.cluster_scaler.slug
  region                    = local.regions.aws
  azs = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
  additional_tags = {}

  ebs_sa        = "ebs-controller"
  efs_sa        = "efs-controller"
  elb_sa        = "elb-controller"
  irsa_platform = local.platforms.sulfoxide.slug
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

