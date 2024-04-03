resource "azurerm_subnet" "main" {
  for_each = var.subnets

  name                 = each.value.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [each.value.cidr_block]

  private_link_service_network_policies_enabled = try(each.value.private_link_endpoint, false)
  private_endpoint_network_policies_enabled     = try(each.value.private_link_endpoint, false)
  service_endpoints                             = try(each.value.service_endpoints, null)

  dynamic "delegation" {
    for_each = each.value.service_delegation.enabled == true ? [1] : []
    content {
      name = each.value.service_delegation.name
      service_delegation {
        name    = each.value.service_delegation.name
        actions = each.value.service_delegation.actions
      }
    }
  }

  # Ignore Service Endpoint Config to reduce noise in state
  lifecycle {
    ignore_changes = [
      service_endpoint_policy_ids
    ]
  }
}