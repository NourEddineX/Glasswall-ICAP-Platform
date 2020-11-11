module "git_server_public_ip" {
  source         = "../azure/public_ip"
  resource_group = module.resource_group.name
  region         = var.azure_region
  service_name   = local.git_service_name
  service_type   = "git_server"
  organisation   = var.organisation
  environment    = var.environment
}

data "azurerm_key_vault" "key_vault" {
  name                = "gw-icap-keyvault"
  resource_group_name = "keyvault"
}

data "azurerm_key_vault_secret" "docker-username" {
  name         = "Docker-PAT-username"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

data "azurerm_key_vault_secret" "docker-password" {
  name         = "Docker-PAT"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

data "azurerm_key_vault_secret" "docker-org" {
  name         = "Docker-PAT-org"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

module "git_server" {
  source         = "../azure/vm"
  resource_group = module.resource_group.name
  organisation   = var.organisation
  environment    = var.environment
  service_name   = local.git_service_name
  service_type   = "git_server"
  size           = "Standard_DS1_v2"
  os_sku         = "7-LVM"
  os_offer       = "RHEL"
  os_publisher   = "RedHat"
  region         = var.azure_region
  custom_data_file_path = base64encode(templatefile("${path.module}/tmpl/git-server-cloud-init.template", {
    docker_username      = data.azurerm_key_vault_secret.docker-username.value
    docker_password      = data.azurerm_key_vault_secret.docker-password.value
    docker_org           = data.azurerm_key_vault_secret.docker-org.value
    docker_gitserver_tag = "1.6"
  }))
  subnet_id          = module.subnet.id
  public_ip_id       = module.git_server_public_ip.id
  public_key_openssh = tls_private_key.ssh.public_key_openssh
  security_group_rules = {
   ssh = {
      name                                      = "git_ssh"
      priority                                  = "1003"
      direction                                 = "Inbound"
      access                                    = "Allow"
      protocol                                  = "tcp"
      source_port_range                         = "*"
      destination_port_range                    = "22"
      source_address_prefix                     = "*"
      destination_address_prefix                = "*"
  },
  http = {
      name                                      = "git_http"
      priority                                  = "1004"
      direction                                 = "Inbound"
      access                                    = "Allow"
      protocol                                  = "tcp"
      source_port_range                         = "*"
      destination_port_range                    = "80"
      source_address_prefix                     = "*"
      destination_address_prefix                = "*"
    }
  }
}

resource "azurerm_dns_a_record" "git_server" {
  name                = local.git_service_name
  zone_name           = data.azurerm_dns_zone.curlywurly_zone.name
  resource_group_name = "gw-icap-rg-dns"
  ttl                 = 300
  records             = [module.git_server.linux_vm_private_ips]
}

module "security_group_rules" {
  source                      = "../azure/security-group-rules"
  network_security_group_name = module.security_group.name
  resource_group_name         = module.resource_group.name
  security_group_rules        = {
   ssh = {
      name                                      = "git_ssh"
      priority                                  = "1003"
      direction                                 = "Inbound"
      access                                    = "Allow"
      protocol                                  = "tcp"
      source_port_range                         = "*"
      destination_port_range                    = "22"
      #source_address_prefix                     = module.rancher_server.linux_vm_private_ips
      #destination_address_prefix                = module.git_server.linux_vm_private_ips
  },
  http = {
      name                                      = "git_http"
      priority                                  = "1004"
      direction                                 = "Inbound"
      access                                    = "Allow"
      protocol                                  = "tcp"
      source_port_range                         = "*"
      destination_port_range                    = "80"
      #source_address_prefix                     = module.rancher_server.linux_vm_private_ips
      #destination_address_prefix                = module.git_server.linux_vm_private_ips
    }
  }
}