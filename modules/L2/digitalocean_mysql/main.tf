resource "digitalocean_database_cluster" "this" {
  name       = local.lpsm
  engine     = "mysql"
  version    = "8"
  size       = var.size
  region     = var.region
  node_count = 1
}

resource "digitalocean_database_db" "this" {
  for_each   = var.databases
  cluster_id = digitalocean_database_cluster.this.id
  name       = each.key
}

data "digitalocean_database_ca" "ca" {
  cluster_id = digitalocean_database_cluster.this.id
}
