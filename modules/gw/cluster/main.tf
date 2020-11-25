locals {
  short_region = substr(var.azure_region, 0, 3)
  cluster_name = "${var.service_name}-${local.short_region}-${var.suffix}"
}

module "azure_cloud_credentials" {
  source              = "../../rancher/cloud_credentials"
  rancher_admin_url   = var.rancher_admin_url
  rancher_admin_token = var.rancher_admin_token
  credential_name     = local.cluster_name
  client_id           = var.client_id
  client_secret       = var.client_secret
  subscription_id     = var.subscription_id
}

module "setting" {
  source            = "../../rancher/setting"
  rancher_admin_url    = var.rancher_admin_url
  rancher_admin_token  = var.rancher_admin_token
  setting_name      = "server-url"
  setting_value     = var.rancher_internal_api_url
}

# this module creates the resource group, network, subnet, peering connection.
module "infra" {
  source                   = "../infra"
  organisation             = var.organisation
  environment              = var.environment
  rancher_admin_url        = var.rancher_admin_url
  rancher_internal_api_url = var.rancher_internal_api_url
  rancher_admin_token      = var.rancher_admin_token
  suffix                   = var.suffix
  service_name             = "${var.service_name}-${local.short_region}-${var.suffix}1"
  azure_region             = var.azure_region
  client_id                = var.client_id
  tenant_id                = var.tenant_id
  client_secret            = var.client_secret
  subscription_id          = var.subscription_id
  cluster_address_space    = var.cluster_address_space
  cluster_subnet_cidr      = var.cluster_subnet_cidr
  public_key_openssh       = var.public_key_openssh
  rancher_resource_group   = var.rancher_resource_group
  rancher_network_id       = var.rancher_network_id
  rancher_network          = var.rancher_network
  backend_port             = var.cluster_backend_port
  public_port              = var.cluster_public_port
}

module "cluster" {
  source                         = "../../rancher/cluster"
  count                          = var.cluster_quantity

  organisation                   = var.organisation
  environment                    = var.environment
  rancher_admin_url              = var.rancher_admin_url
  rancher_internal_api_url       = var.rancher_internal_api_url
  rancher_admin_token            = var.rancher_admin_token
  cluster_name                   = "${local.cluster_name}${count.index+1}"
  client_id                      = var.client_id
  tenant_id                      = var.tenant_id
  client_secret                  = var.client_secret
  subscription_id                = var.subscription_id
  resource_group                 = module.infra.resource_group_name
  virtual_network_name           = module.infra.network_name
  subnet_name                    = module.infra.subnet_name

  subnet_id                         = module.infra.subnet_id
  master_scaleset_size              = var.master_scaleset_size
  master_scaleset_sku_capacity      = var.master_scaleset_sku_capacity
  master_scaleset_admin_user        = var.master_scaleset_admin_user
  worker_scaleset_size              = var.worker_scaleset_size
  worker_scaleset_sku_capacity      = var.worker_scaleset_sku_capacity
  worker_scaleset_admin_user        = var.worker_scaleset_admin_user
  worker_lb_backend_address_pool_id = [module.infra.worker_lbap_id]
  worker_lb_probe_id                = module.infra.worker_ingress_probe_id

  os_publisher                      = var.os_publisher
  os_offer                          = var.os_offer
  os_sku                            = var.os_sku
  os_version                        = var.os_version
  public_key_openssh                = var.public_key_openssh

  scaleset_name                     = "${local.cluster_name}-master"
}