data "infisical_projects" "this" {
  slug = var.project_name
}

resource "infisical_secret" "cluster_connector" {

  name         = var.secret_name
  workspace_id = data.infisical_projects.this.id
  env_slug     = var.landscape
  folder_path  = "/"

  value = jsonencode({
    name   = var.name
    server = var.server
    config = var.config
  })
}