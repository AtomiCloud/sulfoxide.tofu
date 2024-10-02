locals {

  landscape = local.landscapes.entei.slug
  cluster   = local.clusters.vultr.blue

  k8s_version = "v1.30.3+1"
  instance_type = "vc2-4c-8gb"
  max = 8
}