resource "azurerm_virtual_network" "main" {
  name                = var.virtual_network.name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  address_space       = var.virtual_network.address_space
  dns_servers         = var.virtual_network.dns_servers
  tags                = var.tags
}