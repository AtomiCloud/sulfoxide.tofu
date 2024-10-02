output "name" {
  depends_on = [
    infisical_project.this,
    infisical_project_environment.this,
    infisical_secret.id,
    infisical_secret.secret,
  ]
  value = infisical_project.this.name
}


output "slug" {
  depends_on = [
    infisical_project.this,
    infisical_project_environment.this,
    infisical_secret.id,
    infisical_secret.secret,
  ]
  value = infisical_project.this.slug
}

output "id" {
  value = infisical_project.this.id
}