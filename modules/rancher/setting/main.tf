provider "rancher2" {
  alias = "admin"
  api_url = var.rancher_admin_url
  token_key = var.rancher_admin_token
  insecure = true
}

resource "rancher2_setting" "main" {
  provider  = rancher2.admin
  name      = var.setting_name
  value     = var.setting_value
}