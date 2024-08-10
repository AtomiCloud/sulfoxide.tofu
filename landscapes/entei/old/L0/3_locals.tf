locals {
  # main cluster
  digital_ocean_region = "sgp1"

  landscape = local.landscapes.entei.slug

  clusters = {
    opal = "opal"
    ruby = "ruby"
  }

  instance_type = "s-4vcpu-8gb"
  k8s_version   = "1.27"
  min_nodes     = 5
  max_nodes     = 6
}