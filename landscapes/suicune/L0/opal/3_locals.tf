locals {

  landscape = local.landscapes.suicune.slug
  cluster = local.clusters.digital_ocean.blue

  instance_type = "s-4vcpu-8gb"
  k8s_version   = "1.30"
  min_nodes     = 2
  max_nodes     = 6
}