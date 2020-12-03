resource "rancher2_cluster" "main" {
  provider    = rancher2
  name        = var.cluster_name
  description = "Cluster to run the ICAP Service"

  rke_config {
    ignore_docker_version = true
    cloud_provider {
      name = "azure"
      azure_cloud_provider {
        tenant_id                      = var.tenant_id
        subscription_id                = var.subscription_id
        aad_client_id                  = var.client_id
        aad_client_secret              = var.client_secret
        subnet_name                    = var.subnet_name
        vnet_name                      = var.virtual_network_name
        resource_group                 = var.resource_group_name
        primary_scale_set_name         = "${var.cluster_name}-master"
        vm_type                        = "vmss"
        use_instance_metadata          = true
        load_balancer_sku              = "standard"
      }
        #  primary_availability_set_name =
        #  primary_scale_set_name        =
        #  route_table_name              =
    }  
    network {
      plugin  = var.cluster_network_plugin
    }
    services {
       /*kubelet{
        cluster_domain = var.master_dns_name
      }
     etcd {
        creation = "6h"
        retention = "24h"
      }
      kube_api {
        audit_log {
          enabled = true
        }
      }*/
    }
    upgrade_strategy {
      drain = true
      max_unavailable_worker = "20%"
    }
    kubernetes_version = var.kubernetes_version
  }
}

resource "rancher2_token" "main" {
  provider      = rancher2
  cluster_id    = rancher2_cluster.main.id
  description   = "api token for agents to use to join cluster"
  renew         = false
}

module "master_scaleset" {
  source                = "../../azure/scale-set"
  depends_on            = [rancher2_cluster.main]
  organisation          = var.organisation
  environment           = var.environment
  service_name          = "${var.cluster_name}-master"
  tag_cluster_name      = var.cluster_name
  tag_cluster_asg_state = "enabled"
  service_role          = "master"
  resource_group        = var.resource_group_name
  subnet_id             = var.subnet_id

  region                = var.azure_region
  os_publisher          = var.os_publisher
  os_offer              = var.os_offer
  os_sku                = var.os_sku
  os_version            = var.os_version

  size                  = var.master_scaleset_size
  sku_capacity          = var.master_scaleset_sku_capacity
  admin_username        = var.master_scaleset_admin_user

  custom_data = templatefile("${path.module}/tmpl/user-data.template", {
    cluster_name          = var.cluster_name
    rancher_agent_version = "v2.5.1"
    rancher_server_url    = var.rancher_internal_api_url
    rancher_agent_token   = rancher2_token.main.token
    crt_cluster_token     = rancher2_cluster.main.cluster_registration_token.0.token
    node_pool_role        = "master"
    public_key_openssh    = var.public_key_openssh
    rancher_ca_checksum   = ""
  })
  public_key_openssh = var.public_key_openssh
  security_group_rules = {
    k8s = {
      name                       = "icapNodePort"
      priority                   = 1004
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = 6443
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
  loadbalancer               = false
  #lb_backend_address_pool_id = var.master_lb_backend_address_pool_id
  #lb_probe_id                = var.master_lb_probe_id 
}

module "worker_scaleset" {
  source                = "../../azure/scale-set"
  depends_on            = [rancher2_cluster.main]
  organisation          = var.organisation
  environment           = var.environment
  service_name          = "${var.cluster_name}-worker"
  tag_cluster_name      = var.cluster_name
  tag_cluster_asg_state = "enabled"
  service_role          = "worker"

  resource_group        = var.resource_group_name
  subnet_id             = var.subnet_id
  region                = var.azure_region

  os_publisher          = var.os_publisher
  os_offer              = var.os_offer
  os_sku                = var.os_sku
  os_version            = var.os_version

  size                  = var.worker_scaleset_size
  sku_capacity          = var.worker_scaleset_sku_capacity
  admin_username        = var.worker_scaleset_admin_user

  custom_data = templatefile("${path.module}/tmpl/user-data.template", {
    cluster_name          = var.cluster_name
    rancher_agent_version = "v2.5.1"
    rancher_server_url    = var.rancher_admin_url
    rancher_agent_token   = rancher2_token.main.token
    crt_cluster_token     = rancher2_cluster.main.cluster_registration_token.0.token
    node_pool_role        = "worker"
    public_key_openssh    = var.public_key_openssh
    rancher_ca_checksum   = ""
  })
  security_group_rules = {
    icap = {
      name                       = "icapNodePort"
      priority                   = 1004
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = 32323
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
  public_key_openssh         = var.public_key_openssh
  loadbalancer               = true
  lb_backend_address_pool_id = var.worker_lb_backend_address_pool_id
  lb_probe_id                = var.worker_lb_probe_id 
}

