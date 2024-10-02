
resource "kubernetes_namespace" "kubernetes-access" {
  metadata {
    name = var.namespace
  }
}

resource "kubernetes_cluster_role" "kubernetes-access" {
  metadata {
    name = kubernetes_namespace.kubernetes-access.metadata[0].name
  }

  rule {
    verbs = ["*"]
    api_groups = ["*"]
    resources = ["*"]
  }
}

resource "kubernetes_service_account" "kubernetes-access" {
  metadata {
    name = var.resources_name
    namespace = kubernetes_namespace.kubernetes-access.metadata[0].name
  }
}

resource "kubernetes_cluster_role_binding" "kubernetes-access" {
  metadata {
    name = var.resources_name
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.kubernetes-access.metadata[0].name
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.kubernetes-access.metadata[0].name
    namespace = kubernetes_service_account.kubernetes-access.metadata[0].namespace
  }
}

resource "kubernetes_secret" "kubernetes-access" {

  metadata {
    name      = var.resources_name
    namespace = kubernetes_service_account.kubernetes-access.metadata[0].namespace
    annotations = {
      "kubernetes.io/service-account.name" = kubernetes_service_account.kubernetes-access.metadata[0].name
    }
  }

  type = "kubernetes.io/service-account-token"
}