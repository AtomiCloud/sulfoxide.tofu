output "kube_config" {
  value     = digitalocean_kubernetes_cluster.cluster.kube_config
  sensitive = true
}

output "endpoint" {
  value = digitalocean_kubernetes_cluster.cluster.endpoint
}

output "id" {
  value = digitalocean_kubernetes_cluster.cluster.id
}


output "name" {
  value = "${var.landscape}-${var.cluster}"
}

output "server" {
  value = nonsensitive(digitalocean_kubernetes_cluster.cluster.kube_config[0].host)
}

output "config" {
  value = jsonencode({
    bearerToken = digitalocean_kubernetes_cluster.cluster.kube_config[0].token
    tlsClientConfig = {
      insecure = false
      caData   = digitalocean_kubernetes_cluster.cluster.kube_config[0].cluster_ca_certificate
    }
  })
}