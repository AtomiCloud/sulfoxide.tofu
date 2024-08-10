#################
# 01 Prev Stack #
#################

locals {
  opal_cluster = {
    id          = data.terraform_remote_state.L0.outputs.opal_cluster_id
    endpoint    = data.terraform_remote_state.L0.outputs.opal_cluster_endpoint
    kube_config = data.terraform_remote_state.L0.outputs.opal_cluster_config
  }
}

################
# 02 Providers #
################
provider "digitalocean" {
  alias = "opal"
  token = data.doppler_secrets.entei_sulfoxide_terraform.map.OPAL_DIGITALOCEAN_TOKEN
}

provider "helm" {

  alias = "opal"

  kubernetes {
    host                   = local.opal_cluster.kube_config[0].host
    cluster_ca_certificate = base64decode(local.opal_cluster.kube_config[0].cluster_ca_certificate)
    token                  = local.opal_cluster.kube_config[0].token
  }
}
provider "kubernetes" {
  alias = "opal"

  host                   = local.opal_cluster.kube_config[0].host
  cluster_ca_certificate = base64decode(local.opal_cluster.kube_config[0].cluster_ca_certificate)
  token                  = local.opal_cluster.kube_config[0].token
}

######################
# 03 External Secret #
######################
module "opal_external_secrets" {
  source = "../../../modules/L1/external_secrets"

  providers = {
    helm       = helm.opal
    kubernetes = kubernetes.opal
  }

  landscape = local.landscape
  platform  = local.platforms.sulfoxide.slug
  service   = local.platforms.sulfoxide.services.secrets_engine.slug

  root_secret = data.doppler_secrets.sulfoxide_sos.map.SULFOXIDE_SOS
}

###############
# 04 vCluster #
###############

module "opal_vcluster_db" {
  source = "../../../modules/L2/digitalocean_mysql"

  providers = {
    digitalocean = digitalocean.opal
  }

  landscape = local.landscape
  platform  = local.platforms.sulfoxide.slug
  service   = local.platforms.sulfoxide.services.vcluster.slug
  module    = "pichu-mysql"


  databases = {
    "pichu_opal"   = "pichu_admin"
    "pikachu_opal" = "pikachu_admin"
    "raichu_opal"  = "raichu_admin"
  }
  region = local.regions.digital_ocean
}

resource "doppler_secret" "entei_vcluster_db_endpoint" {
  for_each = module.opal_vcluster_db.db_name

  project = "${local.platforms.sulfoxide.slug}-${local.platforms.sulfoxide.services.vcluster.slug}"
  config  = local.landscape

  name  = "${upper(each.key)}_K3S_DATASTORE_ENDPOINT"
  value = "mysql://${module.opal_vcluster_db.username}:${module.opal_vcluster_db.password}@tcp(${module.opal_vcluster_db.host}:${module.opal_vcluster_db.port})/${module.opal_vcluster_db.db_name[each.key]}"
}

resource "doppler_secret" "entei_vcluster_db_ca" {
  for_each = module.opal_vcluster_db.db_name

  project = "${local.platforms.sulfoxide.slug}-${local.platforms.sulfoxide.services.vcluster.slug}"
  config  = local.landscape

  name  = "${upper(each.key)}_K3S_DATASTORE_CA"
  value = module.opal_vcluster_db.ca
}