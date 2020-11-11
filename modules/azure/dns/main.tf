resource "azurerm_resource_group" "dns_rg" {
  name     = var.resource_group_name
  location = var.location
}

data "azurerm_dns_zone" "dns_zone" {
  name                = var.dns_zone
  resource_group_name = azurerm_resource_group.dns_rg.name
}

resource "azurerm_dns_a_record" "dns_record" {
  name                = var.dns_a_record_name
  zone_name           = data.azurerm_dns_zone.dns_zone.name
  resource_group_name = azurerm_resource_group.dns_rg.name
  ttl                 = 60
  records             = var.list_of_load_balancer_ips
}