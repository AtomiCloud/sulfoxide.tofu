output "cluster_name" {
  value = module.cluster.name
}

output "cluster_server" {
  value = module.cluster.server
}

output "cluster_config" {
  value     = module.cluster.config
  sensitive = true
}

output "cluster_endpoint" {
  value = module.cluster.endpoint
}

output "karpenter_role_arn" {
  value = module.cluster.karpenter_role_arn
}

output "karpenter_node_role_name" {
  value = module.cluster.karpenter_node_role_name
}

output "irsa_role_arn" {
  value = module.cluster.irsa_role_arn
}

output "vpc_id" {
  value = module.cluster.vpc_id
}