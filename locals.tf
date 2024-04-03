locals {
  macro_environment = {
    dev  = "nonprod"
    test = "nonprod"
    prod = "prod"
  }
  storage_account_name = local.macro_environment == "prod" ? "prod_sa_name" : "nonprod_sa_name"
  subnet_prefixes = {
    extra_small = cidrsubnets(var.virtual_network.address_space, 1, 2, 4)
    small       = cidrsubnets(var.virtual_network.address_space, 1, 2, 4)
    medium      = cidrsubnets(var.virtual_network.address_space, 1, 2, 4, 4)
    large       = cidrsubnets(var.virtual_network.address_space, 1, 2, 4, 4, 4)
    extra_large = cidrsubnets(var.virtual_network.address_space, 1, 2, 4, 4, 4)
  }
  default_subnets = {
    extra_small = {
      snet_1 = {
        name       = "snet_1"
        cidr_block = local.subnet_prefixes["small"][0]
      }
      snet_2 = {
        name       = "snet_2"
        cidr_block = local.subnet_prefixes["small"][1]
      }
      snet_3 = {
        name       = "snet_3"
        cidr_block = local.subnet_prefixes["small"][2]
      }
    }
    small = {
      snet_1 = {
        name       = "snet_1"
        cidr_block = local.subnet_prefixes["small"][0]
      }
      snet_2 = {
        name       = "snet_2"
        cidr_block = local.subnet_prefixes["small"][1]
      }
      snet_3 = {
        name       = "snet_3"
        cidr_block = local.subnet_prefixes["small"][2]
      }
    }
    medium = {
      snet_1 = {
        name       = "snet_1"
        cidr_block = local.subnet_prefixes["medium"][0]
      }
      snet_2 = {
        name       = "snet_2"
        cidr_block = local.subnet_prefixes["medium"][1]
      }
      snet_3 = {
        name       = "snet_3"
        cidr_block = local.subnet_prefixes["medium"][2]
      }
      snet_4 = {
        name       = "snet_4"
        cidr_block = local.subnet_prefixes["medium"][3]
      }
    }
    large = {
      snet_1 = {
        name       = "snet_1"
        cidr_block = local.subnet_prefixes["medium"][0]
      }
      snet_2 = {
        name       = "snet_2"
        cidr_block = local.subnet_prefixes["medium"][1]
      }
      snet_3 = {
        name       = "snet_3"
        cidr_block = local.subnet_prefixes["medium"][2]
      }
      snet_4 = {
        name       = "snet_4"
        cidr_block = local.subnet_prefixes["medium"][3]
      }
      snet_5 = {
        name       = "snet_5"
        cidr_block = local.subnet_prefixes["medium"][4]
      }
    }
    extra_large = {
      snet_1 = {
        name       = "snet_1"
        cidr_block = local.subnet_prefixes["medium"][0]
      }
      snet_2 = {
        name       = "snet_2"
        cidr_block = local.subnet_prefixes["medium"][1]
      }
      snet_3 = {
        name       = "snet_3"
        cidr_block = local.subnet_prefixes["medium"][2]
      }
      snet_4 = {
        name       = "snet_4"
        cidr_block = local.subnet_prefixes["medium"][3]
      }
      snet_5 = {
        name       = "snet_5"
        cidr_block = local.subnet_prefixes["medium"][4]
      }
    }
  }
  resource_ids = {
    vwan_hub = {
      prod_eus     = data.azurerm_virtual_hub.prod_eus.id
      prod_wus3    = data.azurerm_virtual_hub.prod_wus3.id
      nonprod_eus  = data.azurerm_virtual_hub.nonprod_eus.id
      nonprod_wus3 = data.azurerm_virtual_hub.nonprod_wus3.id
    }
  }
}