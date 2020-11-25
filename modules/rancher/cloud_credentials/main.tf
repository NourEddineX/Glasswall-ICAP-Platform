/*provider "rancher2" {
  alias = "admin"
  api_url = var.rancher_admin_url
  token_key = var.rancher_admin_token
  insecure = true
}*/

resource "rancher2_cloud_credential" "credentials" {
  provider    = rancher2.admin
  name = var.credential_name
  azure_credential_config{
    client_id = var.client_id
    client_secret = var.client_secret
    subscription_id = var.subscription_id
  }
}