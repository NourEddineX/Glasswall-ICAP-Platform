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

variable "setting_name" {
  description = "Set the name"
  type        = string
}

variable "setting_value" {
  description = "Set the value"
  type        = string
}