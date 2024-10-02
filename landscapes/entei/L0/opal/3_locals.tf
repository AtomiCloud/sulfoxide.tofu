locals {

  landscape = local.landscapes.entei.slug
  cluster   = local.clusters.digital_ocean.blue

  k8s_version = "1.30"
  instance_type = "s-4vcpu-8gb"
  max = 8
}