resource "azurerm_public_ip" "main" {
  name                 = "pip-${var.bastion.name}"
  location             = azurerm_resource_group.main.location
  resource_group_name  = azurerm_resource_group.main.name
  allocation_method    = "Static"
  sku                  = "Standard"
  ddos_protection_mode = "Enabled"
  tags                 = var.tags
}