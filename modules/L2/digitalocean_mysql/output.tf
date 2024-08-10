output "username" {
  value = digitalocean_database_cluster.this.user
}

output "password" {
  value = digitalocean_database_cluster.this.password
}

output "host" {
  value = digitalocean_database_cluster.this.host

}

output "db_name" {
  value = { for key, db in digitalocean_database_db.this : key => db.name }
}

output "port" {
  value = digitalocean_database_cluster.this.port
}

output "ca" {
  value = data.digitalocean_database_ca.ca.certificate
}