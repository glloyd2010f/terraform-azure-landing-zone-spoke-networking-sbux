resource "azurerm_network_security_group" "main" {
  for_each = var.network_security_group

  name                = each.key.value.name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  tags                = var.tags

  # Ignore security rules as they are being created by a separate deployment
  lifecycle {
    ignore_changes = [
      security_rule
    ]
  }
}