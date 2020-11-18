provider "rancher2" {
  alias     = "admin"
  api_url   = var.rancher_admin_url
  token_key = var.rancher_admin_token
  insecure  = true
}
