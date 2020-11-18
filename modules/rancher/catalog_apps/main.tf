resource "rancher2_catalog_v2" "foo" {
  cluster_id = var.cluster_id
  name       = "foo"
  git_repo   = var.helm_charts_repo_url
  git_branch = var.helm_charts_repo_branch
}