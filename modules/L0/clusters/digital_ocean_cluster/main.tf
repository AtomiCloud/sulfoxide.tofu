data "digitalocean_kubernetes_versions" "version" {
  version_prefix = "${var.k8s_version}."
}

resource "digitalocean_kubernetes_cluster" "cluster" {
  name         = "${var.landscape}-${var.cluster}-cluster"
  region       = var.region
  auto_upgrade = true
  version      = data.digitalocean_kubernetes_versions.version.latest_version



  maintenance_policy {
    start_time = "00:00"
    day        = "sunday"
  }

  node_pool {
    name       = "autoscale-worker-pool"
    size       = var.instance_type
    auto_scale = true
    min_nodes  = var.min_nodes
    max_nodes  = var.max_nodes
  }
}