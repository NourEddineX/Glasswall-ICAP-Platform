variable "catalogue_name" {
  description = "The catalogue name"
  type = string
}

variable "cluster_ids" {
  description = "A list of cluster ids"
  type = list(string)
}