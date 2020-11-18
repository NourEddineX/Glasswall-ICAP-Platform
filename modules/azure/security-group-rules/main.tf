
#resource "azurerm_network_security_rule" "main_prefix"{
#    name                        = var.service_name
#    priority                    = var.priority
#    direction                   = var.direction
#    access                      = var.access
#    protocol                    = var.protocol
#    source_port_range           = var.source_port_range
#    destination_port_range      = var.destination_port_range
#    source_address_prefix       = var.source_address_prefix
#    destination_address_prefix  = var.destination_address_prefix
#    resource_group_name         = var.resource_group_name
#    network_security_group_name = var.network_security_group_name
#}

resource "azurerm_network_security_rule" "main"{
    name                                        = var.service_name
    priority                                    = var.priority
    direction                                   = var.direction
    access                                      = var.access
    protocol                                    = var.protocol
    source_port_range                           = var.source_port_range
    destination_port_range                      = var.destination_port_range
    source_application_security_group_ids       = var.source_sg_ids
    destination_application_security_group_ids  = var.destination_sg_ids
    resource_group_name                         = var.resource_group_name
    network_security_group_name                 = var.network_security_group_name
}