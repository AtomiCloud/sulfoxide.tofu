provider "kubernetes" {
  host                   = local.kube_config.clusters[0].cluster.server
  cluster_ca_certificate = base64decode(local.kube_config.clusters[0].cluster.certificate-authority-data)

  client_key = base64decode(local.kube_config.users[0].user.client-key-data)
  client_certificate = base64decode(local.kube_config.users[0].user.client-certificate-data)
}

module "proxy_secret" {
  source = "../../cluster_secret"

  name           = local.name
  namespace      = "kubernetes-access"
  resources_name = "kubernetes-access"
  server         = local.kube_config.clusters[0].cluster.server
}