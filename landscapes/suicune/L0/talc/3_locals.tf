locals {

  landscape = local.landscapes.suicune.slug
  cluster = local.clusters.vultr.green

  instance_type = "vc2-4c-8gb"
  k8s_version   = "v1.30.3+1"
  max_nodes = 4
  min_nodes = 3
}