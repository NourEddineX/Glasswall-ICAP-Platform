provider "rancher2" {
  alias = "admin"
  api_url = var.rancher_admin_url
  token_key = var.rancher_admin_token
  insecure = true
}

resource "rancher2_catalog" "catalogue" {
  cluster_id = var.cluster_id
  name       = "catalogue"
  url        = var.helm_charts_repo_url
  branch     = var.helm_charts_repo_branch
}
