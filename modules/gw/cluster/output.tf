output "cloud_credentials_id" {
  value = module.azure_cloud_credentials.id
}

output "resource_group_name" {
  value = module.infra.resource_group_name
}

output "network_name" {
  value = module.infra.network_name
}

output "network_id" {
  value = module.infra.network_id
}

output "subnet_name" {
  value = module.infra.subnet_name
}
/*
output "cluster_name" {
  value = module.cluster.cluster_name
}

output "cluster_id" {
  value = module.cluster.cluster_id
}

output "crt_cluster_token" {
  value = module.cluster.crt_cluster_token
}

output "crt_cluster_id" {
  value = module.cluster.crt_cluster_id
}

output "crt_cluster_node_command" {
  value = module.cluster.crt_cluster_node_command
}

output "kubernetes_version" {
  value = module.cluster.kubernetes_version
}

output "cluster_access_key" {
  value = module.cluster.access_key
}

output "cluster_secret_key" {
  value = module.cluster.secret_key
}

output "cluster_token_enabled" {
  value = module.cluster.token_enabled
}*/

output "cluster_worker_lb_dns_name" {
  value = module.infra.worker_lb_dns_name
}

output "worker_lb_ip_address" {
  value = module.infra.worker_lb_ip_address
}

