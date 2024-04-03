variable "location" {
  description = "Location of the resource group."
  type        = string
}

variable "environment" {
  description = "Type of environment (e.g. dev, test, prod)"
  type        = string
  validation {
    condition     = can(regex("^(dev|test|prod)$", var.environment))
    error_message = "Environment must be either dev, test, or prod"
  }
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "virtual_network" {
  type = map(object({
    name          = string
    address_space = list(string)
    dns_servers   = list(string)
  }))
  description = <<-DESCRIPTION
    type = map(object({
      name = (Required) The name of the Azure Virtual Network.
      address_space = (Required) The address space that is used the virtual network. You can supply more than one address space.
      dns_servers = (Required) List of IP addresses of DNS servers.
    }))
  DESCRIPTION
}

variable "subnets" {
  description = "Subnet configurations. If using a private endpoint on the subnet, enable_private_endpoint_policy must be false"
  type = map(object({
    name       = string
    cidr_block = string
  }))
  default = {}
}

variable "bastion" {
  type = object({
    name                   = string
    sku                    = string
    scale_units            = number
    copy_paste_enabled     = bool
    file_copy_enabled      = bool
    ip_connect_enabled     = bool
    shareable_link_enabled = bool
    tunneling_enabled      = bool
  })
  description = <<-DESCRIPTION
    (Required) The Bastion Host Configuration. Defaults to null."
    type = object({
      name = (Required) The name of the NSG Security Rule.
      sku = (Required) Network protocol this rule applies to. Possible values include Tcp, Udp, Icmp, Esp, Ah or * (which matches all).
      scale_units = (Optional) Number, The number of scale units with which to provision the Bastion Host. Possible values are between 2 and 50, can be changed when sku is Standard. scale_units is always 2 when sku is Basic. Defaults to 2.
      copy_paste_enabled = (Optional) Boolean, Is Copy/Paste feature enabled for the Bastion Host. Defaults to true.
      file_copy_enabled = (Optional) Boolean, Is File Copy feature enabled for the Bastion Host. Only supported when sku is Standard. Defaults to false.
      ip_connect_enabled = (Optional) Boolean, Is IP Connect feature enabled for the Bastion Host. Only supported when sku is Standard. Defaults to false.
      shareable_link_enabled = (Optional) Boolean, Is Shareable Link feature enabled for the Bastion Host. Only supported when sku is Standard. Defaults to false.
      tunneling_enabled = (Optional) Boolean, Is Tunneling feature enabled for the Bastion Host. Only supported when sku is Standard. Defaults to false.
    })
  DESCRIPTION
  default     = null
}

variable "network_security_group" {
  type = object({
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
  description = <<-DESCRIPTION
    (Required) The Network Security Group Configuration."
    type = object({
      name = (Required) The name of the Network Security Group.
      security_rules = map(object({
        name = (Required) The name of the NSG Security Rule.
        description = (Optional) A description for this rule. Restricted to 140 characters.
        protocol = (Required) Network protocol this rule applies to. Possible values include Tcp, Udp, Icmp, Esp, Ah or * (which matches all).
        source_port_range = (Required) Source Port or Range. Integer or range between 0 and 65535 or * to match any.
        destination_port_range = (Required) Destination Port or Range. Integer or range between 0 and 65535 or * to match any.
        source_address_prefix = (Required) CIDR or source IP range or * to match any IP. Tags such as VirtualNetwork, AzureLoadBalancer and Internet can also be used.
        destination_address_prefix = (Required) CIDR or destination IP range or * to match any IP. Tags such as VirtualNetwork, AzureLoadBalancer and Internet can also be used.
        access =  (Required) Specifies whether network traffic is allowed or denied. Possible values are Allow and Deny.
        priority = Required) Specifies the priority of the rule. The value can be between 100 and 4096. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule.
        direction = (Required) The direction specifies if rule will be evaluated on incoming or outgoing traffic. Possible values are Inbound and Outbound.
      }))
    })
  DESCRIPTION
}

variable "network_watcher" {
  type = map(object({
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
  description = <<-DESCRIPTION
    type = map(object({
      name = (Required) ID of the Log Analytics Workspace to which to send Diagnostic Settings.
      flow_log = map(object({
        name = (Required) Specifies the name of the flow log. Restricted to 80 characters.
        enabled = (Required) Specifies whether the flow log is enabled. Possible values are true and false. Defaults to false.
        storage_account_id = (Required) Specifies the ID of the storage account which will hold the flow log.
        retention_policy    = object({
          enabled = (Required) Specifies whether the retention policy is enabled. Possible values are true and false. Defaults to true.
          days    = (Required) Specifies the number of days to retain flow log records. Possible values are between 1 and 730. Defaults to 0.
        })
        traffic_analytics = object({
          enabled               = (Required) Specifies whether traffic analytics is enabled. Possible values are true and false. Defaults to false.
          interval_in_minutes   = (Required) Specifies the interval in minutes for how often the traffic analytics will be recalculated. Possible values are 10, 20, 30, and 60. Defaults to 60.
        })
      }))
    }))
  DESCRIPTION
}

variable "log_analytics" {
  type = optional(map(object({
    resource_id        = optional(string)
    workspace_id       = optional(string)
    workspace_location = optional(string)
  })))
  description = <<-DESCRIPTION
    type = optional(map(object({
      resource_id = (Optional) Specifies the Resource ID of the Log Analytics Workspace to which to send Diagnostic Settings.
      workspace_id = (Optional) Specifies the Workspace ID of the Log Analytics Workspace to which to send Diagnostic Settings.
      workspace_location = (Optional) Specifies the location of the Log Analytics Workspace to which to send Diagnostic Settings.
    })))
  DESCRIPTION
}

variable "tags" {
  description = "Tags to set for for module resources"
  type        = map(string)
  default     = {}
}