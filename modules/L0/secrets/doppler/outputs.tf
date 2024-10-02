output "name" {
  depends_on = [
    doppler_project.this,
    doppler_environment.this,
    doppler_service_token.this,
  ]
  value = doppler_project.this.name
}

output "id" {
  value = doppler_project.this.id
}