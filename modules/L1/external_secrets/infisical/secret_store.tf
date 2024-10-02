resource "helm_release" "secret_store" {

  depends_on = [
    helm_release.external_secret_operator,
    kubernetes_secret_v1.external_secret_operator,
    kubernetes_namespace_v1.secret_engine,
  ]

  name             = "secret-store"
  namespace        = local.namespace
  atomic           = true
  wait             = true
  create_namespace = false

  chart = "${path.module}/chart"

  values = [
    yamlencode({
      name = "infisical"
      labels = merge(local.labels, {
        "atomi.cloud/module" = "secret-store"
        "atomi.cloud/bump"   = "b-${var.bump}"
      })
      annotations = merge(local.annotations, {
        "atomi.cloud/module" = "secret-store"
      })
      secretName      = local.secret_name
      clientIdKey     = local.client_id_key
      clientSecretKey = local.client_secret_key
      project         = var.sos_project
      env             = var.landscape
      api             = var.infisical_api
      path            = var.path

    })
  ]
}
