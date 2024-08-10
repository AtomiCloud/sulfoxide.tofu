resource "neon_project" "this" {
  name                = local.lpsm
  region_id           = var.region
  compute_provisioner = "k8s-neonvm"

  #  history_retention_seconds = var.history_retention_seconds

}

resource "neon_role" "this" {
  for_each   = var.databases
  name       = each.value
  branch_id  = neon_project.this.default_branch_id
  project_id = neon_project.this.id
}

resource "neon_database" "this" {
  for_each   = var.databases
  name       = each.key
  owner_name = neon_role.this[each.key].name
  branch_id  = neon_project.this.default_branch_id
  project_id = neon_project.this.id
}
