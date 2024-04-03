resource "azurerm_network_security_rule" "main" {
  for_each = var.network_security_group.security_rules

  name                         = each.value.name
  resource_group_name          = azurerm_resource_group.main.name
  network_security_group_name  = azurerm_network_security_group.main[each.key.value.name].name
  description                  = each.value.description
  protocol                     = each.value.protocol
  source_port_range            = each.value.source_port_range
  destination_port_range       = each.value.destination_port_range
  source_address_prefix        = each.value.source_address_prefixes == null ? each.value.source_address_prefix : null
  source_address_prefixes      = each.value.source_address_prefix == null ? each.value.source_address_prefixes : null
  destination_address_prefix   = each.value.destination_address_prefixes == null ? each.value.destination_address_prefix : null
  destination_address_prefixes = each.value.destination_address_prefix == null ? each.value.destination_address_prefixes : null
  access                       = each.value.access
  priority                     = each.value.priority
  direction                    = each.value.direction
}