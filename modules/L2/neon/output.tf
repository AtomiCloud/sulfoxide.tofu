output "username" {
  value = { for key, role in neon_role.this : key => role.name }
}

output "password" {
  value = { for key, role in neon_role.this : key => role.password }

}

output "host" {
  value = neon_project.this.database_host

}

output "db_name" {
  value = { for key, role in neon_database.this : key => role.name }
}