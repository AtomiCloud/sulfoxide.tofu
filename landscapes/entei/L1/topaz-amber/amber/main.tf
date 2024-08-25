
resource "kubernetes_namespace" "sulfoxide" {
  metadata {
    name = local.platforms.sulfoxide.slug
  }
}

resource "kubernetes_secret" "infisical" {
  metadata {
    name      = "${local.platforms.sulfoxide.services.secrets_engine.slug}-infisical"
    namespace = kubernetes_namespace.sulfoxide.metadata[0].name
  }
  data = {
    CLIENT_ID     = data.infisical_secrets.sulfoxide_sos.secrets["${upper(local.sos_project_snake)}_CLIENT_ID"].value
    CLIENT_SECRET = data.infisical_secrets.sulfoxide_sos.secrets["${upper(local.sos_project_snake)}_CLIENT_SECRET"].value
  }
}