terraform {
  backend "azurerm" {
    resource_group_name  = "tf-state-resource-group"
    storage_account_name = "gwtfstatestorageaccount"
    container_name       = "tfstatecontainer"
    key                  = "gitserver-terraform.tfstate"
  }
}

data "terraform_remote_state" "rancher_server" {
  backend = "azurerm"
  config = {
    resource_group_name  = "tf-state-resource-group"
    storage_account_name = "gwtfstatestorageaccount"
    container_name       = "tfstatecontainer"
    key                  = "rancher-server-terraform.tfstate"
  }
}

resource "null_resource" "git_server" {
  provisioner "local-exec" {
    command = "scp -r src ../rancher-bootstrap"
    interpreter = ["/bin/bash", "-c"]
  }

  provisioner "remote-exec" {
    inline = [
      "cd ../rancher-bootstrap/src",
      "docker build git-server",
      "cd example",
      "docker-compose up",
    ]
  }
}
