
terraform {
  backend "azurerm" {
    resource_group_name  = "tf-state-resource-group"
    storage_account_name = "gwtfstatestorageaccount"
    container_name       = "tfstatecontainer"
    key                  = "gw-rancher-prod-main-terraform.tfstate"
  }
}

module "rancher_server" {
  source                 = "../../../workspace/rancher-bootstrap"
  organisation           = "gw"
  environment            = "prod"
  project                = "rancher-server"
  suffix                 = "a1"
  git_server_version     = "2.08"
  azure_region           = "ukwest" # ukwest
  dns_zone_name          = "prod.icap-proxy.curlywurly.me"
  key_vault_resource_group = "keyvault"
  key_vault_name           = "gw-icap-keyvault"
  tenant_id              = "7049e6a3-141d-463a-836b-1ba40d3ff653"
  subscription_id        = "b8177f86-515f-4bff-bd08-1b9535dbc31b"
}