output "endpoint" {
  value = module.eks.cluster_endpoint
}

output "id" {
  value = module.eks.cluster_id
}

output "name" {
  value = module.proxy_secret.name
}

output "server" {
  value = module.proxy_secret.server
}

output "config" {
  value = module.proxy_secret.config
}

output "karpenter_node_role_name" {
  value = module.karpenter.node_iam_role_name
}

output "karpenter_role_arn" {
  value = module.karpenter.iam_role_arn
}

output "irsa_role_arn" {
  value = module.iam_eks_role.iam_role_arn
}

output "vpc_id" {
  value = module.vpc.vpc_id
}