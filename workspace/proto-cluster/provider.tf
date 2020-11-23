provider "rancher2" {
  alias     = "admin"
  api_url   = local.rancher_api_url
  token_key = local.rancher_admin_token
  insecure  = true
}
