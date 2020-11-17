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
resource "azurerm_application_security_group" "git_server" {
  name                = "${local.git_service_name}-asg"
  location            = var.azure_region
  resource_group_name = module.resource_group.name
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
    docker_gitserver_tag = "1.0"
  }))
  subnet_id          = module.subnet.id
  public_ip_id       = module.git_server_public_ip.id
  public_key_openssh = tls_private_key.ssh.public_key_openssh
  security_group_rules = {
   ssh = {
      name                                      = "ssh"
      priority                                  = "1001"
      direction                                 = "Inbound"
      access                                    = "Allow"
      protocol                                  = "tcp"
      source_port_range                         = "22"
      destination_port_range                    = "22"
      source_application_security_group_ids     = [ azurerm_application_security_group.rancher_server.id ]
      destination_application_security_group_ids = [ azurerm_application_security_group.gitserver.id ]
  },
  https = {
      name                                      = "https"
      priority                                  = "1002"
      direction                                 = "Inbound"
      access                                    = "Allow"
      protocol                                  = "tcp"
      source_port_range                         = "443"
      destination_port_range                    = "443"
      source_application_security_group_ids     = [ azurerm_application_security_group.rancher_server.id ]
      destination_application_security_group_ids = [ azurerm_application_security_group.gitserver.id ]
    },
  http = {
      name                                      = "http"
      priority                                  = "1003"
      direction                                 = "Inbound"
      access                                    = "Allow"
      protocol                                  = "tcp"
      source_port_range                         = "80"
      destination_port_range                    = "80"
      source_application_security_group_ids     = [ azurerm_application_security_group.rancher_server.id ]
      destination_application_security_group_ids = [ azurerm_application_security_group.gitserver.id ]
    }
  }
}

resource "azurerm_dns_a_record" "git_server" {
  name                = local.git_service_name
  zone_name           = data.azurerm_dns_zone.curlywurly_zone.name
  resource_group_name = "gw-icap-rg-dns"
  ttl                 = 300
  records             = [module.git_server.linux_vm_public_ips]
}