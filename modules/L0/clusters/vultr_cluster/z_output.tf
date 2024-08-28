
locals {
  kube_config = yamldecode(base64decode(vultr_kubernetes.k8.kube_config))
}

output "kube_config" {
  value     = local.kube_config
  sensitive = true
}

output "endpoint" {
  value = nonsensitive(module.proxy_secret.server)
}

output "id" {
  value = vultr_kubernetes.k8.id
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