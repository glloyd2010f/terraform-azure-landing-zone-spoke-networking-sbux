output "bastion_host" {
  description = "Resource ID for the Azure Virtual Network."
  value       = azurerm_virtual_network.main.id
}

output "virtual_network" {
  description = "Resource Object for the Azure Virtual Network."
  value       = azurerm_virtual_network.main
}

output "subnets" {
  description = "Name and Resource ID for the Virtual Network Subnets."
  value = {
    for key, value in azurerm_subnet.main : key => {
      name = value.name
      id   = value.id
    }
  }
}

output "network_watcher" {
  description = "Resource Object for the Azure Network Watcher."
  value       = azurerm_network_watcher.main
}

output "network_watcher_flow_log" {
  description = "Resource Object for the Azure Network Watcher Flow Log."
  value       = azurerm_network_watcher_flow_log.main
}

output "log_analytics" {
  description = "Resource Object for the Azure Log Analytics Workspace."
  value       = azurerm_log_analytics_workspace.main
}

output "network_security_group" {
  description = "Resource Object for the Azure Network Security Group."
  value = {
    for key, value in azurerm_network_security_group.main : key => {
      name           = value.name
      id             = value.id
      security_rules = value.security_rule
    }
  }
}