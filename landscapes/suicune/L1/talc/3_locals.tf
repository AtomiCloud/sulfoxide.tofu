locals {

  landscape = local.landscapes.suicune.slug
  cluster   = local.clusters.vultr.green

  sos_project = "${local.platforms.sulfoxide.slug}-${local.platforms.sulfoxide.services.sos.slug}"
  sos_project_snake = join("_", split("-", local.sos_project))
}