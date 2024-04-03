data "azurerm_virtual_hub" "prod_eus" {
  provider = azurerm.connectivity

  name                = "sbux-prod-hub-eastus"
  resource_group_name = "sbux-prod-connectivity"
}

data "azurerm_virtual_hub" "prod_wus3" {
  provider = azurerm.connectivity

  name                = "sbux-prod-hub-westus3"
  resource_group_name = "sbux-prod-connectivity"
}

data "azurerm_virtual_hub" "nonprod_eus" {
  provider = azurerm.connectivity

  name                = "sbux-nonprod-hub-eastus"
  resource_group_name = "sbux-nonprod-connectivity"
}

data "azurerm_virtual_hub" "nonprod_wus3" {
  provider = azurerm.connectivity

  name                = "sbux-nonprod-hub-westus3"
  resource_group_name = "sbux-nonprod-connectivity"
}