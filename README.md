<!-- BEGIN_TF_DOCS -->
# Terraform Azure Spoke Networking

- [Terraform Azure Spoke Networking](#terraform-azure-spoke-networking)
  - [Purpose](#purpose)
  - [Details](#details)
  - [Gotchas](#gotchas)
  - [Usage](#usage)

## Purpose

Creates and configures the Networking Components for Azure Landing Zone Spokes.

## Details
- Creates a Azure Resource Group for the Spoke Resources.
- Creates a Azure Virtual Network (VNET).
  - Creates a Virtual WAN Hub Connection.
- Creates Virtual Network Subnets.
- Creates Network Security Group(s).
  - Associates Network Security Groups (NSGs) to Subnets.
  - Creates Network Security Group Rules.
- Creates Network Watcher Flow Logs
- Optionals:
  - Creates a Azure Bastion Host.
    - Creates a associated Public IP Address

## Gotchas
- As of 3/7/2024 this Module is still in Alpha.
- Versioning breaks down as follows
  - 0.0.X - Alpha Version
  - 0.X.X - Beta Version
  - X.X.X - GA Version
    - Once in GA this will follow the [Semantic Versioning 2.0.0](https://semver.org/#semantic-versioning-200) process.

## Usage

This module may be used via a module call specifying the following input variables.

```
provider "azurerm" {
  storage_use_azuread = true
}

resource "azurerm_resource_group" "example" {
  name      = "insight-example"
  location  = "eastus2"
}

module "" {
  source   = "<source-path>"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  depends_on = [
    azurerm_resource_group.example
  ]
}
```

## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 1.5)

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (~> 3.90.0)

## Providers

The following providers are used by this module:

- <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) (~> 3.90.0)

- <a name="provider_azurerm.connectivity"></a> [azurerm.connectivity](#provider\_azurerm.connectivity) (~> 3.90.0)

## Required Inputs

The following input variables are required:

### <a name="input_environment"></a> [environment](#input\_environment)

Description: Type of environment (e.g. dev, test, prod)

Type: `string`

### <a name="input_location"></a> [location](#input\_location)

Description: Location of the resource group.

Type: `string`

### <a name="input_log_analytics"></a> [log\_analytics](#input\_log\_analytics)

Description: type = optional(map(object({  
  resource\_id = (Optional) Specifies the Resource ID of the Log Analytics Workspace to which to send Diagnostic Settings.  
  workspace\_id = (Optional) Specifies the Workspace ID of the Log Analytics Workspace to which to send Diagnostic Settings.  
  workspace\_location = (Optional) Specifies the location of the Log Analytics Workspace to which to send Diagnostic Settings.
})))

Type:

```hcl
optional(map(object({
    resource_id        = optional(string)
    workspace_id       = optional(string)
    workspace_location = optional(string)
  })))
```

### <a name="input_network_security_group"></a> [network\_security\_group](#input\_network\_security\_group)

Description: (Required) The Network Security Group Configuration."  
type = object({  
  name = (Required) The name of the Network Security Group.  
  security\_rules = map(object({  
    name = (Required) The name of the NSG Security Rule.  
    description = (Optional) A description for this rule. Restricted to 140 characters.  
    protocol = (Required) Network protocol this rule applies to. Possible values include Tcp, Udp, Icmp, Esp, Ah or * (which matches all).  
    source\_port\_range = (Required) Source Port or Range. Integer or range between 0 and 65535 or * to match any.  
    destination\_port\_range = (Required) Destination Port or Range. Integer or range between 0 and 65535 or * to match any.  
    source\_address\_prefix = (Required) CIDR or source IP range or * to match any IP. Tags such as VirtualNetwork, AzureLoadBalancer and Internet can also be used.  
    destination\_address\_prefix = (Required) CIDR or destination IP range or * to match any IP. Tags such as VirtualNetwork, AzureLoadBalancer and Internet can also be used.  
    access =  (Required) Specifies whether network traffic is allowed or denied. Possible values are Allow and Deny.  
    priority = Required) Specifies the priority of the rule. The value can be between 100 and 4096. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule.  
    direction = (Required) The direction specifies if rule will be evaluated on incoming or outgoing traffic. Possible values are Inbound and Outbound.
  }))
})

Type:

```hcl
object({
    name = string
    security_rules = map(object({
      name                         = string
      description                  = optional(string)
      protocol                     = string
      source_port_range            = string
      destination_port_range       = string
      source_address_prefix        = optional(string)
      source_address_prefixes      = optional(list(string))
      destination_address_prefix   = optional(string)
      destination_address_prefixes = optional(list(string))
      access                       = string
      priority                     = number
      direction                    = string
    }))
  })
```

### <a name="input_network_watcher"></a> [network\_watcher](#input\_network\_watcher)

Description: type = map(object({  
  name = (Required) ID of the Log Analytics Workspace to which to send Diagnostic Settings.  
  flow\_log = map(object({  
    name = (Required) Specifies the name of the flow log. Restricted to 80 characters.  
    enabled = (Required) Specifies whether the flow log is enabled. Possible values are true and false. Defaults to false.  
    storage\_account\_id = (Required) Specifies the ID of the storage account which will hold the flow log.  
    retention\_policy    = object({  
      enabled = (Required) Specifies whether the retention policy is enabled. Possible values are true and false. Defaults to true.  
      days    = (Required) Specifies the number of days to retain flow log records. Possible values are between 1 and 730. Defaults to 0.
    })  
    traffic\_analytics = object({  
      enabled               = (Required) Specifies whether traffic analytics is enabled. Possible values are true and false. Defaults to false.  
      interval\_in\_minutes   = (Required) Specifies the interval in minutes for how often the traffic analytics will be recalculated. Possible values are 10, 20, 30, and 60. Defaults to 60.
    })
  }))
}))

Type:

```hcl
map(object({
    name = string
    flow_log = map(object({
      name               = string
      enabled            = bool
      storage_account_id = string
      retention_policy = object({
        enabled = bool
        days    = number
      })
      traffic_analytics = object({
        enabled             = bool
        interval_in_minutes = number
      })
    }))
  }))
```

### <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name)

Description: Resource group name

Type: `string`

### <a name="input_virtual_network"></a> [virtual\_network](#input\_virtual\_network)

Description: type = map(object({  
  name = (Required) The name of the Azure Virtual Network.  
  address\_space = (Required) The address space that is used the virtual network. You can supply more than one address space.  
  dns\_servers = (Required) List of IP addresses of DNS servers.
}))

Type:

```hcl
map(object({
    name          = string
    address_space = list(string)
    dns_servers      = list(string)
  }))
```

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_bastion"></a> [bastion](#input\_bastion)

Description: (Required) The Bastion Host Configuration. Defaults to null."  
type = object({  
  name = (Required) The name of the NSG Security Rule.  
  sku = (Required) Network protocol this rule applies to. Possible values include Tcp, Udp, Icmp, Esp, Ah or * (which matches all).  
  scale\_units = (Optional) Number, The number of scale units with which to provision the Bastion Host. Possible values are between 2 and 50, can be changed when sku is Standard. scale\_units is always 2 when sku is Basic. Defaults to 2.  
  copy\_paste\_enabled = (Optional) Boolean, Is Copy/Paste feature enabled for the Bastion Host. Defaults to true.  
  file\_copy\_enabled = (Optional) Boolean, Is File Copy feature enabled for the Bastion Host. Only supported when sku is Standard. Defaults to false.  
  ip\_connect\_enabled = (Optional) Boolean, Is IP Connect feature enabled for the Bastion Host. Only supported when sku is Standard. Defaults to false.  
  shareable\_link\_enabled = (Optional) Boolean, Is Shareable Link feature enabled for the Bastion Host. Only supported when sku is Standard. Defaults to false.  
  tunneling\_enabled = (Optional) Boolean, Is Tunneling feature enabled for the Bastion Host. Only supported when sku is Standard. Defaults to false.
})

Type:

```hcl
object({
    name                   = string
    sku                    = string
    scale_units            = number
    copy_paste_enabled     = bool
    file_copy_enabled      = bool
    ip_connect_enabled     = bool
    shareable_link_enabled = bool
    tunneling_enabled      = bool
  })
```

Default: `null`

### <a name="input_subnets"></a> [subnets](#input\_subnets)

Description: Subnet configurations. If using a private endpoint on the subnet, enable\_private\_endpoint\_policy must be false

Type:

```hcl
map(object({
    name       = string
    cidr_block = string
  }))
```

Default: `{}`

### <a name="input_tags"></a> [tags](#input\_tags)

Description: Tags to set for for module resources

Type: `map(string)`

Default: `{}`

## Outputs

The following outputs are exported:

### <a name="output_bastion_host"></a> [bastion\_host](#output\_bastion\_host)

Description: Resource ID for the Azure Virtual Network.

### <a name="output_log_analytics"></a> [log\_analytics](#output\_log\_analytics)

Description: Resource Object for the Azure Log Analytics Workspace.

### <a name="output_network_security_group"></a> [network\_security\_group](#output\_network\_security\_group)

Description: Resource Object for the Azure Network Security Group.

### <a name="output_network_watcher"></a> [network\_watcher](#output\_network\_watcher)

Description: Resource Object for the Azure Network Watcher.

### <a name="output_network_watcher_flow_log"></a> [network\_watcher\_flow\_log](#output\_network\_watcher\_flow\_log)

Description: Resource Object for the Azure Network Watcher Flow Log.

### <a name="output_subnets"></a> [subnets](#output\_subnets)

Description: Name and Resource ID for the Virtual Network Subnets.

### <a name="output_virtual_network"></a> [virtual\_network](#output\_virtual\_network)

Description: Resource Object for the Azure Virtual Network.
<!-- END_TF_DOCS -->


#### _this README is auto-generated by [terraform-docs](https://terraform-docs.io)_