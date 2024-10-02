locals {
  securityContext = {
    allowPrivilegeEscalation = false
    capabilities = {
      drop = ["ALL"]
    }
    privileged             = false
    readOnlyRootFilesystem = true
    runAsNonRoot           = true
  }
}

resource "helm_release" "external_secret_operator" {

  depends_on = [kubernetes_namespace_v1.secret_engine]

  name = "external-secrets-operator"

  create_namespace = false
  namespace        = local.namespace
  atomic           = true
  wait             = true

  repository = "https://charts.external-secrets.io"
  chart      = "external-secrets"

  values = [
    yamlencode({
      installCRDs     = true
      securityContext = local.securityContext
      resources = {
        request = {
          cpu    = "50m"
          memory = "128Mi"
        }
        limits = {
          cpu    = "200m"
          memory = "256Mi"
        }
      }

      podLabels = merge(local.labels, {
        "atomi.cloud/module" = "operator"
      })
      podAnnotations = merge(local.annotations, {
        "atomi.cloud/module" = "operator"
      })

      webhook = {
        port = 9443

        securityContext = local.securityContext
        resources = {
          request = {
            cpu    = "50m"
            memory = "128Mi"
          }
          limits = {
            cpu    = "200m"
            memory = "256Mi"
          }
        }
        podLabels = merge(local.labels, {
          "atomi.cloud/module" = "webhook"
        })
        podAnnotations = merge(local.annotations, {
          "atomi.cloud/module" = "webhook"
        })

      }

      certController = {

        securityContext = local.securityContext
        resources = {
          request = {
            cpu    = "50m"
            memory = "128Mi"
          }
          limits = {
            cpu    = "200m"
            memory = "256Mi"
          }
        }
        podLabels = merge(local.labels, {
          "atomi.cloud/module" = "cert-controller"
        })
        podAnnotations = merge(local.annotations, {
          "atomi.cloud/module" = "cert-controller"
        })
      }
    })
  ]
}


