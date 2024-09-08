output "kube_config" {
  value     = digitalocean_kubernetes_cluster.cluster.kube_config
  sensitive = true
}

output "endpoint" {
  value = nonsensitive(module.proxy_secret.server)
}

output "id" {
  value = digitalocean_kubernetes_cluster.cluster.id
}


output "name" {
  value = "${var.landscape}-${var.cluster}"
}

output "server" {
  value = nonsensitive(module.proxy_secret.server)
}

output "config" {
  value =module.proxy_secret.config
}