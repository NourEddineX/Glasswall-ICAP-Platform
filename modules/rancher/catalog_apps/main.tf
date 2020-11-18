resource "rancher2_catalog_v2" "catalogue" {
  cluster_id = var.cluster_id
  name       = "catalogue"
  git_repo   = var.helm_charts_repo_url
  git_branch = var.helm_charts_repo_branch
}

resource "rancher2_project" "icapservice" {
  name = "icapservice"
  cluster_id = var.cluster_id
}

resource "rancher2_multi_cluster_app" "icapadaptation" {
  catalog_name = rancher2_catalog_v2.catalogue.name
  name = "icapadaptation"
  targets {
    project_id = rancher2_project.icapservice.id
  }
  template_name = "icap-adaptation"
  template_version = "0.0.3"
  roles = ["project-member"]
}

