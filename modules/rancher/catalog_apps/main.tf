resource "rancher2_catalog" "catalogue" {
  cluster_id = var.cluster_id
  name       = "catalogue"
  url        = var.helm_charts_repo_url
  branch     = var.helm_charts_repo_branch
}

resource "rancher2_project" "icapservice" {
  name       = "icapservice"
  cluster_id = var.cluster_id
}

resource "rancher2_multi_cluster_app" "icapadaptation" {
  catalog_name = rancher2_catalog.catalogue.name
  name         = "icapadaptation"
  targets {
    project_id = rancher2_project.icapservice.id
  }
  template_name = "icap-adaptation"
  roles         = ["cluster-owner"]
}

resource "rancher2_multi_cluster_app" "rabbitmq" {
  catalog_name = rancher2_catalog.catalogue.name
  name         = "rabbitmq"
  targets {
    project_id = rancher2_project.icapservice.id
  }
  template_name = "icap-rabbitmq"
  roles         = ["cluster-owner"]
}

resource "rancher2_multi_cluster_app" "systemclusterrole" {
  catalog_name = rancher2_catalog.catalogue.name
  name         = "systemclusterrole"
  targets {
    project_id = rancher2_project.icapservice.id
  }
  template_name = "systemclusterrole"
  roles         = ["cluster-owner"]
}

