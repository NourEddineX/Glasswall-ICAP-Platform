
terraform {
  backend "azurerm" {
    resource_group_name  = "tf-state-resource-group"
    storage_account_name = "gwtfstatestorageaccount"
    container_name       = "tfstatecontainer"
    key                  = "gw-rancher-clusters-prod-main-terraform.tfstate"
  }
}

data "terraform_remote_state" "rancher_server" {
  backend = "azurerm"
  config = {
    resource_group_name  = "tf-state-resource-group"
    storage_account_name = "gwtfstatestorageaccount"
    container_name       = "tfstatecontainer"
    key                  = "gw-rancher-prod-main-terraform.tfstate"
  }
}

module "rancher_clusters" {
    source                            = "../../../workspace/proto-multi-clusters"
    organisation                      = "gw"
    environment                       = "prod"
    branch                            = "main"
    icap_cluster_suffix_r1            = "b"
    icap_cluster_suffix_r2            = "c"
    icap_cluster_suffix_r3            = "d"
    icap_cluster_quantity             = 3
    icap_master_scaleset_sku_capacity = 2
    icap_worker_scaleset_sku_capacity = 1
    dns_zone                          = "prod.icap-proxy.curlywurly.me"
    tenant_id                         = "7049e6a3-141d-463a-836b-1ba40d3ff653"
    subscription_id                   = "b8177f86-515f-4bff-bd08-1b9535dbc31b"
    rancher_suffix                    = data.terraform_remote_state.rancher_server.outputs.rancher_suffix
    rancher_api_url                   = data.terraform_remote_state.rancher_server.outputs.rancher_api_url
    rancher_internal_api_url          = data.terraform_remote_state.rancher_server.outputs.rancher_internal_api_url
    rancher_network                   = data.terraform_remote_state.rancher_server.outputs.network
    rancher_server_name               = data.terraform_remote_state.rancher_server.outputs.rancher_server_url
    rancher_admin_token               = data.terraform_remote_state.rancher_server.outputs.rancher_admin_token
    rancher_network_name              = data.terraform_remote_state.rancher_server.outputs.network
    rancher_network_id                = data.terraform_remote_state.rancher_server.outputs.network_id
    rancher_resource_group            = data.terraform_remote_state.rancher_server.outputs.resource_group
    rancher_subnet_id                 = data.terraform_remote_state.rancher_server.outputs.subnet_id
    rancher_subnet_prefix             = data.terraform_remote_state.rancher_server.outputs.subnet_prefix
    rancher_subnet_name               = data.terraform_remote_state.rancher_server.outputs.subnet_name
    rancher_region                    = data.terraform_remote_state.rancher_server.outputs.region
    rancher_agent_version             = data.terraform_remote_state.rancher_server.outputs.rancher_agent_version
    git_server_url                    = data.terraform_remote_state.rancher_server.outputs.git_server_url
    public_key_openssh                = data.terraform_remote_state.rancher_server.outputs.public_key_openssh
    rancher_internal_ip               = data.terraform_remote_state.rancher_server.outputs.linux_vm_private_ips
}
