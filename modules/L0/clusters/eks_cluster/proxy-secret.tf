provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

  exec {
    env = {
      AWS_ACCESS_KEY_ID = var.access_key
      AWS_SECRET_ACCESS_KEY = var.secret_key
    }
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
  }
}

module "proxy_secret" {
  source = "../../cluster_secret"

  name           = local.name
  namespace      = "kubernetes-access"
  resources_name = "kubernetes-access"
  server         = module.eks.cluster_endpoint
}