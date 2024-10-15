
resource "vultr_kubernetes" "k8" {
  region  = var.region
  label   = "${var.landscape}-${var.cluster}"
  version = var.k8s_version
  ha_controlplanes = true

  node_pools {
    node_quantity = var.min_nodes
    plan          = var.instance_type
    label         = "default-nodepool"
    auto_scaler   = true
    min_nodes     = var.min_nodes
    max_nodes     = var.max_nodes
  }
}