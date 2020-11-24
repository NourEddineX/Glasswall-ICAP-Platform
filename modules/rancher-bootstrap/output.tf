output "rancher_security_group_id" {
  value = module.security_group.id
}

output "gitserver_security_group_id" {
  value = module.security_group.id
}

output "linux_vm_public_ips" {
  value = module.rancher_server.linux_vm_public_ips
}

output "linux_vm_private_ips" {
  value = module.rancher_server.linux_vm_private_ips
}

output "tls_private_key" {
  value = tls_private_key.ssh.private_key_pem
}

output "public_key_openssh" {
  value = tls_private_key.ssh.public_key_openssh
}

output "git_server_public_ips" {
  value = module.git_server.linux_vm_public_ips
}

output "git_server_url" {
  value = "${azurerm_dns_a_record.git_server.fqdn}/icap-infrastructure.git"
}

output "admin_user" {
  value = rancher2_bootstrap.admin.user
}

output "admin_password" {
  value = random_password.password.result
}

output "admin_url" {
  value = rancher2_bootstrap.admin.url
}

output "admin_token" {
  value = rancher2_bootstrap.admin.token
}

output "admin_token_id" {
  value = rancher2_bootstrap.admin.token_id
}

output "rancher_internal_api_url" {
  value = azurerm_dns_a_record.rancher_internal_server.fqdn
}

output "rancher_api_url" {
  value = azurerm_dns_a_record.rancher_server.fqdn
}

output "rancher_resource_group" {
  value = module.resource_group.name
}

output "rancher_network" {
  value = module.network.name
}
output "network_id" {
  value = module.network.id
}
