output "r1_cluster_name" {
  value = module.icap_cluster_proto_z1.cluster_name
}

output "r1_resource_group" {
  value = module.icap_cluster_proto_z1.resource_group_name
}

output "r1_network_name" {
  value = module.icap_cluster_proto_z1.network_name
}

output "r1_network_id" {
  value = module.icap_cluster_proto_z1.network_id
}

output "r1_subnet_name" {
  value = module.icap_cluster_proto_z1.subnet_name
}

output "r1_cluster_worker_lb_dns_name" {
  value = module.icap_cluster_proto_z1.cluster_worker_lb_dns_name
}

output "r1_cluster_worker_lb_ip_addr" {
  value = module.icap_cluster_proto_z1.worker_lb_ip_address
}
