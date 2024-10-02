output "name" {
  value = var.name
}

output "server" {
  value = var.server
}

output "config" {
  value = jsonencode({
    bearerToken = kubernetes_secret.kubernetes-access.data["token"]
    tlsClientConfig = {
      insecure = false
      caData = base64encode(kubernetes_secret.kubernetes-access.data["ca.crt"])
    }
  })
  sensitive = true
}
