locals {
  short_region = substr(var.azure_region, 0, 3)
  cluster_name = "${var.service_name}-${var.suffix}-${local.short_region}"
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
  service_name             = "${var.service_name}-${var.suffix}-${local.short_region}"
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
  os_version               = var.os_version
  os_sku                   = var.os_sku
  os_offer                 = var.os_offer
  os_publisher             = var.os_publisher
}

module "cluster" {
  source               = "../../rancher/cluster"
  organisation         = var.organisation
  environment          = var.environment
  rancher_admin_url    = var.rancher_admin_url
  rancher_admin_token  = var.rancher_admin_token
  cluster_name         = local.cluster_name
  service_name         = var.service_name
  azure_region         = var.azure_region
  client_id            = var.client_id
  tenant_id            = var.tenant_id
  client_secret        = var.client_secret
  subscription_id      = var.subscription_id
  resource_group       = module.infra.resource_group_name
  virtual_network_name = module.infra.network_name
  subnet_name          = module.infra.subnet_name
  scaleset_name        = "${local.cluster_name}-master"
}

module "master_scaleset" {
  source                = "../../azure/scale-set"
  depends_on            = [module.cluster]
  organisation          = var.organisation
  environment           = var.environment
  service_name          = "${local.cluster_name}-master"
  tag_cluster_name      = local.cluster_name
  tag_cluster_asg_state = "enabled"
  service_role          = "master"
  resource_group        = module.infra.resource_group_name
  subnet_id             = module.infra.subnet_id
  region                = var.azure_region
  os_publisher          = var.os_publisher
  os_offer              = var.os_offer
  os_sku                = var.os_sku
  os_version            = var.os_version
  size                  = var.master_scaleset_size
  sku_capacity          = var.master_scaleset_sku_capacity
  admin_username        = var.master_scaleset_admin_user
  custom_data = templatefile("${path.module}/tmpl/user-data.template", {
    cluster_name          = local.cluster_name
    rancher_agent_version = "v2.5.1"
    rancher_server_url    = var.rancher_internal_api_url
    rancher_agent_token   = module.cluster.token
    crt_cluster_token     = module.cluster.crt_cluster_token
    node_pool_role        = "master"
    public_key_openssh    = var.public_key_openssh
    rancher_ca_checksum   = ""
  })
  public_key_openssh = var.public_key_openssh
  loadbalancer       = false
}

module "worker_scaleset" {
  source                = "../../azure/scale-set"
  depends_on            = [module.cluster]
  organisation          = var.organisation
  environment           = var.environment
  service_name          = "${local.cluster_name}-worker"
  tag_cluster_name      = local.cluster_name
  tag_cluster_asg_state = "enabled"
  service_role          = "worker"
  resource_group        = module.infra.resource_group_name
  subnet_id             = module.infra.subnet_id
  region                = var.azure_region
  os_publisher          = var.os_publisher
  os_offer              = var.os_offer
  os_sku                = var.os_sku
  os_version            = var.os_version
  size                  = var.worker_scaleset_size
  sku_capacity          = var.worker_scaleset_sku_capacity
  admin_username        = var.worker_scaleset_admin_user
  custom_data = templatefile("${path.module}/tmpl/user-data.template", {
    cluster_name          = local.cluster_name
    rancher_agent_version = "v2.5.1"
    rancher_server_url    = var.rancher_admin_url
    rancher_agent_token   = module.cluster.token
    crt_cluster_token     = module.cluster.crt_cluster_token
    node_pool_role        = "worker"
    public_key_openssh    = var.public_key_openssh
    rancher_ca_checksum   = ""
  })
  #custom_data_file_path      = data.template_file.worker_scaleset_nodes.rendered
  public_key_openssh         = var.public_key_openssh
  loadbalancer               = true
  lb_backend_address_pool_id = [module.infra.worker_lbap_id]
  lb_probe_id                = module.infra.worker_ingress_probe_id
}

