provider "kubernetes" {
  host                   = digitalocean_kubernetes_cluster.cluster.kube_config[0].host
  cluster_ca_certificate = base64decode(digitalocean_kubernetes_cluster.cluster.kube_config[0].cluster_ca_certificate)

  token = digitalocean_kubernetes_cluster.cluster.kube_config[0].token
}

module "proxy_secret" {
  source = "../../cluster_secret"

  name           = local.name
  namespace      = "kubernetes-access"
  resources_name = "kubernetes-access"
  server         = digitalocean_kubernetes_cluster.cluster.kube_config[0].host
}