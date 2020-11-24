resource "rancher2_catalog" "catalogue" {
  provider    = rancher2.admin
  name       = "catalogue"
  url        = var.helm_charts_repo_url
  branch     = var.helm_charts_repo_branch
}


resource "rancher2_project" "icapservice" {
  provider    = rancher2.admin
  name       = "icapservice"
  cluster_id = var.cluster_id
  wait_for_cluster = true
}