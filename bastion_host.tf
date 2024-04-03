resource "azurerm_bastion_host" "main" {
  count = var.bastion != null ? 1 : 0

  name                   = var.bastion.name
  location               = azurerm_resource_group.main.location
  resource_group_name    = azurerm_resource_group.main.name
  sku                    = var.bastion.sku
  copy_paste_enabled     = try(var.bastion.copy_paste_enabled, true)
  file_copy_enabled      = title(var.bastion.sku) == "Standard" ? try(var.bastion.file_copy_enabled, true) : null
  ip_connect_enabled     = title(var.bastion.sku) == "Standard" ? try(var.bastion.ip_connect_enabled, false) : null
  scale_units            = title(var.bastion.sku) == "Standard" ? try(var.bastion.scale_units, false) : null
  shareable_link_enabled = title(var.bastion.sku) == "Standard" ? try(var.bastion.shareable_link_enabled, false) : null
  tunneling_enabled      = title(var.bastion.sku) == "Standard" ? try(var.bastion.tunneling_enabled, false) : null
  tags                   = var.tags

  ip_configuration {
    name                 = "default"
    subnet_id            = azurerm_subnet.main["bastion"].id
    public_ip_address_id = azurerm_public_ip.main.id
  }
}