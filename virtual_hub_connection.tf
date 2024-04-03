resource "azurerm_virtual_hub_connection" "main" {
  provider = azurerm.connectivity

  name                      = format("%s-%s-%s", var.virtual_network.name, var.environment, var.location)
  virtual_hub_id            = data.azurerm_virtual_hub.vhub-eastus2.id
  remote_virtual_network_id = azurerm_virtual_network.main.id
  tags                      = var.tags
}