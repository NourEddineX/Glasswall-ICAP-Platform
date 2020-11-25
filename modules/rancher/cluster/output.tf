output "cluster_name" {
  value = rancher2_cluster.main.name
}

output "cluster_id" {
  value = rancher2_cluster.main.id
}

output "crt_cluster_token" {
  value = rancher2_cluster.main.cluster_registration_token.0.token
}

output "crt_cluster_id" {
  value = rancher2_cluster.main.cluster_registration_token.0.cluster_id
}

output "crt_cluster_node_command" {
  value = rancher2_cluster.main.cluster_registration_token.0.node_command
}

output "kubernetes_version" {
  value = var.kubernetes_version
}

output "token_name" {
  value = rancher2_token.main.name
}

output "token" {
  value = rancher2_token.main.token
}

output "access_key" {
  value = rancher2_token.main.access_key
}

output "secret_key" {
  value = rancher2_token.main.secret_key
}

output "token_enabled" {
  value = rancher2_token.main.enabled
}