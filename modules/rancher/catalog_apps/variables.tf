# Rancher API Url
variable "rancher_admin_url" {
  description = "The Rancher API"
  type        = string
}

#Rancher API Admin Token
variable "rancher_admin_token" {
  description = "The Rancher Admin Token"
  type        = string
}

variable "cluster_id" {
  description = "The Rancher Cluster Id"
  type        = string
}

variable "helm_charts_repo_url" {
  description = "The repo url to the helm charts"
  type        = string
}

variable "helm_charts_repo_branch" {
  description = "The branch name of the repo to the helm charts"
  type        = string
}

variable "project_id" {
  description = "The cluster project id"
  type        = string
}




