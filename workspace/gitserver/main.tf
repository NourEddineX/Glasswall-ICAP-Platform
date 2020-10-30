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
    command = "tar -czf gitserver.tar.gz src/"
    interpreter = ["/bin/bash", "-c"]
  }

  provisioner "file" {
    source = "gitserver.tar.gz"
    destination = "/home/azure-user"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo cp gitserver.tar.gz /opt",
      "cd /opt",
      "sudo tar -xzf gitserver.tar.gz",
      "sudo cd gitserver/src",
      "sudo docker-compose up",
    ]
  }
}
