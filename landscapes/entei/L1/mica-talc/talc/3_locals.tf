locals {

  landscape   = local.landscapes.entei.slug
  cluster     = local.clusters.vultr.green
  cluster_set = local.clusters.vultr.set

  sos_project = "${local.platforms.sulfoxide.slug}-${local.platforms.sulfoxide.services.sos.slug}"
  sos_project_snake = join("_", split("-", local.sos_project))
}