################
## 01 provider #
################
#provider "digitalocean" {
#  alias = "ruby"
#  token = data.doppler_secrets.sulfoxide_terraform.map.RUBY_DIGITALOCEAN_TOKEN
#}
#

###############
## 02 cluster #
###############
#module "cluster_ruby" {
#
#  source = "../../../modules/L0/digital_ocean_cluster"
#
#  providers = {
#    digitalocean = digitalocean.ruby
#  }
#
#  cluster       = local.clusters.ruby
#  k8s_version   = local.k8s_version
#  instance_type = local.instance_type
#  landscape     = local.landscape
#  max_nodes     = local.max_nodes
#  min_nodes     = local.min_nodes
#  region        = local.digital_ocean_region
#
#}
#
######################
## 03 cluster access #
######################
#module "kubeconfig_ruby" {
#
#  source = "../../../modules/L0/connector_secret"
#
#  landscape    = local.landscape
#  project_name = "kubernetes-access"
#  secret_name  = "RUBY_KUBECONFIG"
#
#  name   = module.cluster_ruby.name
#  config = module.cluster_ruby.config
#  server = module.cluster_ruby.server
#
#}
#
#module "kubeconfig_ruby_helium" {
#
#  // Admin clusters
#  for_each = local.doppler_landscapes.a
#
#  source = "../../../modules/L0/connector_secret"
#
#  landscape = each.key
#
#  project_name = "${local.platforms.sulfoxide.slug}-${local.platforms.sulfoxide.services.argocd.slug}"
#  secret_name  = "${upper(local.landscape)}_RUBY_KUBECONFIG"
#
#  name   = module.cluster_ruby.name
#  config = module.cluster_ruby.config
#  server = module.cluster_ruby.server
#
#}
#
##############
## 04 Output #
##############
#
#output "ruby_cluster_id" {
#  value = module.cluster_ruby.id
#}
#
#output "ruby_cluster_endpoint" {
#  value = module.cluster_ruby.endpoint
#}
#
#output "ruby_cluster_config" {
#  value     = module.cluster_ruby.kube_config
#  sensitive = true
#}