module "virtual_network" {
  source  = "spacelift.io/starbucks/diagnostic-settings/azure"
  version = "0.1.0"

  resource_id     = azurerm_virtual_network.main.id
  evnironment     = var.environment == "prod" ? "prod" : "nonprod"
  location        = var.location
}

module "bastion_host" {
  source  = "spacelift.io/starbucks/diagnostic-settings/azure"
  version = "0.1.0"

  resource_id     = azurerm_bastion_host.main.id
  evnironment     = var.environment == "prod" ? "prod" : "nonprod"
  location        = var.location
}

module "network_security_group" {
  source  = "spacelift.io/starbucks/diagnostic-settings/azure"
  version = "0.1.0"

  resource_id     = azurerm_network_security_group.main.id
  evnironment     = var.environment == "prod" ? "prod" : "nonprod"
  location        = var.location
}