# Common variables
variable "organisation" {
  description = "Metadata Organisation"
  type        = string
}

variable "environment" {
  description = "Metadata Environment"
  type        = string
}

# Rancher API Url
variable "rancher_admin_url" {
  description = "The Rancher API"
  type        = string
}

#Rancher API Admin Token
variable "rancher_admin_token" {
  description = "The Rancher Admin Token"
  type        = string
}

variable "tenant_id" {
  description = "Service Principal TenantID"
  type        = string
}

variable "client_id" {
  description = "Service Principal ClientID"
  type        = string
}

variable "client_secret" {
  description = "Service Principal Secret"
  type        = string
}

variable "subscription_id" {
  description = "Service Principal Subscription ID"
  type        = string
}

variable "azure_region" {
  description = "The cloud region"
  type        = string
}

variable "cluster_network_plugin" {
  description = "Set the network plugin"
  type        = string
  default     = "canal"
}

variable "cluster_name" {
  description = "This is the name of the cluster"
  type        = string
}

variable "kubernetes_version" {
  description = "The Kubernetes version"
  type        = string
  default     = "v1.19.2-rancher1-1"
}

variable "virtual_network_name" {
  description = "Virtual Network Name"
  type        = string
}

variable "subnet_name" {
  description = "The Subnet Name for the cluster config"
  type        = string
}

variable "subnet_id" {
  description = "The Subnet ID for the ScaleSet"
  type        = string
}

variable "resource_group" {
  description = "the resource group"
  type        = string
}

variable "scaleset_name" {
  description = "The scale set name"
  type        = string
}

variable "public_key_openssh" {
  description = "The Node SSH key"
  type        = string
}

variable "os_offer" {
  description = "Linux OS Offer"
  type        = string
}

variable "os_sku" {
  description = "Linux OS SKU"
  type        = string
}

variable "os_version" {
  description = "Linux OS Version"
  type        = string
  default     = "latest"
}

variable "master_scaleset_size" {
  description = "The K8S Master Scaleset size"
  type        = string
}

variable "master_scaleset_sku_capacity" {
  description = "The K8S Master Scaleset sku capacity"
  type        = string
}

variable "master_scaleset_admin_user" {
  description = "The K8S Master Scaleset admin user"
  type        = string
}

variable "worker_scaleset_size" {
  description = "The K8S Worker Scaleset size"
  type        = string
}

variable "worker_scaleset_sku_capacity" {
  description = "The K8S Worker Scaleset sku capacity"
  type        = string
}

variable "worker_scaleset_admin_user" {
  description = "The K8S Worker Scaleset admin user"
  type        = string
}

variable "worker_lb_backend_address_pool_id" {
  description = "The K8S Worker Scaleset admin user"
  type        = list(string)
}

variable "worker_lb_probe_id" {
  description = "The K8S Worker LB Probe ID from Infra module"
  type        = string
}
