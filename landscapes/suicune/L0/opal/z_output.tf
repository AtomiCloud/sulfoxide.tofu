output "cluster_name" {
  value = module.static_config.name
}

output "cluster_server" {
  value = module.static_config.server
}

output "cluster_config" {
  value     = module.static_config.config
  sensitive = true
}

