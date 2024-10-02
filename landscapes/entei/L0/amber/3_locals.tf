locals {

  landscape = local.landscapes.entei.slug
  cluster   = local.clusters.aws.green


  cidr        = "10.0.0.0/16"
  k8s_version = "1.30"
}