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