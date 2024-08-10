##################
## 01 Prev Stack #
##################
#locals {
#  ruby_cluster = {
#    id          = data.terraform_remote_state.L0.outputs.ruby_cluster_id
#    endpoint    = data.terraform_remote_state.L0.outputs.ruby_cluster_endpoint
#    kube_config = data.terraform_remote_state.L0.outputs.ruby_cluster_config
#  }
#}
#
#
#################
## 02 Providers #
#################
#provider "digitalocean" {
#  alias = "ruby"
#  token = data.doppler_secrets.entei_sulfoxide_terraform.map.RUBY_DIGITALOCEAN_TOKEN
#}
#
#provider "helm" {
#
#  alias = "ruby"
#
#  kubernetes {
#    host                   = local.ruby_cluster.kube_config[0].host
#    cluster_ca_certificate = base64decode(local.ruby_cluster.kube_config[0].cluster_ca_certificate)
#    token                  = local.ruby_cluster.kube_config[0].token
#  }
#}
#
#provider "kubernetes" {
#
#  alias = "ruby"
#
#  host                   = local.ruby_cluster.kube_config[0].host
#  cluster_ca_certificate = base64decode(local.ruby_cluster.kube_config[0].cluster_ca_certificate)
#  token                  = local.ruby_cluster.kube_config[0].token
#}


#######################
## 03 External Secret #
#######################
#module "ruby_external_secrets" {
#  source = "../../../modules/L1/external_secrets"
#
#  providers = {
#    helm       = helm.ruby
#    kubernetes = kubernetes.ruby
#  }
#
#  landscape = local.landscape
#  platform  = local.platforms.sulfoxide.slug
#  service   = local.platforms.sulfoxide.services.secrets_engine.slug
#
#  root_secret = data.doppler_secrets.sulfoxide_sos.map.SULFOXIDE_SOS
#}
#
#
################
## 04 vCluster #
################
#module "ruby_vcluster_db" {
#  source = "../../../modules/L2/digitalocean_mysql"
#
#  providers = {
#    digitalocean = digitalocean.ruby
#  }
#
#  landscape = local.landscape
#  platform  = local.platforms.sulfoxide.slug
#  service   = local.platforms.sulfoxide.services.vcluster.slug
#  module    = "pichu-mysql"
#
#
#  databases = {
#    "pichu_ruby"   = "pichu_admin"
#    "pikachu_ruby" = "pikachu_admin"
#    "raichu_ruby"  = "raichu_admin"
#  }
#  region = local.regions.digital_ocean
#}
#
#resource "doppler_secret" "entei_ruby_vcluster_db_endpoint" {
#  for_each = module.ruby_vcluster_db.db_name
#
#  project = "${local.platforms.sulfoxide.slug}-${local.platforms.sulfoxide.services.vcluster.slug}"
#  config  = local.landscape
#
#  name  = "${upper(each.key)}_K3S_DATASTORE_ENDPOINT"
#  value = "mysql://${module.ruby_vcluster_db.username}:${module.ruby_vcluster_db.password}@tcp(${module.ruby_vcluster_db.host}:${module.ruby_vcluster_db.port})/${module.ruby_vcluster_db.db_name[each.key]}"
#}
#
#resource "doppler_secret" "entei_ruby_vcluster_db_ca" {
#  for_each = module.ruby_vcluster_db.db_name
#
#  project = "${local.platforms.sulfoxide.slug}-${local.platforms.sulfoxide.services.vcluster.slug}"
#  config  = local.landscape
#
#  name  = "${upper(each.key)}_K3S_DATASTORE_CA"
#  value = module.ruby_vcluster_db.ca
#}
