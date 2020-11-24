resource "rancher2_multi_cluster_app" "icapadaptation" {
  catalog_name = var.catalogue_name
  name         = "icapadaptation"
  targets {
    project_id = var.cluster_ids
  }
  targets {
    project_id = var.cluster_ids
  }
  template_name = "icap-adaptation"
  roles         = ["cluster-owner"]
}

resource "rancher2_multi_cluster_app" "rabbitmq" {
  catalog_name = var.catalogue_name
  name         = "rabbitmq"
  targets {
    project_id = var.cluster_ids
  }
  template_name = "icap-rabbitmq"
  roles         = ["cluster-owner"]
}

resource "rancher2_multi_cluster_app" "systemclusterrole" {
  catalog_name = var.catalogue_name
  name         = "systemclusterrole"
  targets {
    project_id = var.cluster_ids
  }
  template_name = "systemclusterrole"
  roles         = ["cluster-owner"]
}