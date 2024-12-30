data "infisical_projects" "this" {
  slug = var.project
}

locals {
  combinations = flatten([
    for k1, v1 in var.physical_landscapes : [
      for k2, v2 in var.virtual_landscapes : {
        physical = k1
        virtual = k2
      }
    ]
  ])
  combinations_map = { for combination in local.combinations : "${combination.physical}-${combination.virtual}" => combination }
}

resource "infisical_secret" "this" {
  for_each     = local.combinations_map
  name         = "${upper(each.value.virtual)}_${var.secret}"
  value        = "$${${each.value.virtual}.${var.secret}}"
  env_slug     = each.value.physical
  workspace_id = data.infisical_projects.this.id
  folder_path  = "/"
}