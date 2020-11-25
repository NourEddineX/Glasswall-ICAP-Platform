
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

# Rancher API Url
variable "rancher_internal_api_url" {
  description = "The Rancher API"
  type        = string
}

#Rancher API Admin Token
variable "rancher_admin_token" {
  description = "The Rancher Admin Token"
  type        = string
}

variable "rancher_network" {
  description = "The Rancher Network"
  type        = string
}

#Rancher API Admin Token
variable "rancher_resource_group" {
  description = "The Rancher Resource Group"
  type        = string
}


variable "service_name" {
  description = "The name of the service"
  type        = string
}


variable "cluster_quantity" {
  description = "Quantity of clusters in Region"
  type        = number
}

variable "suffix" {
  description = "The Suffix"
  type        = string
}

variable "infra_module" {
  description = "The Suffix"
  type        = string
  default     = 0
}

variable "azure_region" {
  description = "The cloud region"
  type        = string
}

variable "tenant_id" {
  description = "Service Principal tenantID"
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

variable "cluster_subnet_cidr" {
  description = "Subnet CIDR"
  type        = list(string)
}

variable "cluster_subnet_prefix" {
  description = "Subnet Prefix"
  type        = string
}

variable "public_key_openssh" {
  description = "The Node SSH key"
  type        = string
}

variable "rancher_network_id" {
  description = "The Network ID"
  type        = string
}

variable "os_publisher" {
  description = "OS Publisher"
  type        = string
}

variable "os_offer" {
  description = "OS Offer"
  type        = string
}

variable "os_sku" {
  description = "OS SKU"
  type        = string
}

variable "os_version" {
  description = "OS Version"
  type        = string
}

variable "master_scaleset_size" {
  description = "The Instance Size"
  type        = string
}

variable "master_scaleset_admin_user" {
  description = "The Instance Admin User"
  type        = string
}

variable "master_scaleset_sku_capacity" {
  description = "Total instances to begin with"
  type        = string
}

variable "worker_scaleset_size" {
  description = "The Instance Size"
  type        = string
}

variable "worker_scaleset_admin_user" {
  description = "The Instance Size"
  type        = string
}

variable "worker_scaleset_sku_capacity" {
  description = "The Instance Size"
  type        = string
}

variable "cluster_address_space" {
  description = "Address Space"
  type        = list(string)
}

variable "cluster_backend_port" {
  description = "Backend Port"
  type        = string
}

variable "cluster_public_port" {
  description = "Public Port"
  type        = string
}