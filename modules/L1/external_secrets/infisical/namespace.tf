resource "kubernetes_namespace_v1" "secret_engine" {
  metadata {
    name = local.namespace
  }
}