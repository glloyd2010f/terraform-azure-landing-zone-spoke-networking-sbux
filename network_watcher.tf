resource "azurerm_network_watcher" "main" {
  name                = var.network_watcher.name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  tags                = var.tags
}