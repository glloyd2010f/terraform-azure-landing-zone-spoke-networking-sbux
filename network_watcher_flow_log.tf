resource "azurerm_network_watcher_flow_log" "main" {
  network_watcher_name = azurerm_network_watcher.main.name
  resource_group_name  = azurerm_resource_group.main.name
  name                 = var.network_watcher.flow_log.name

  network_security_group_id = azurerm_network_security_group.main.id
  storage_account_id        = var.network_watcher.flow_log.storage_account_id
  enabled                   = var.network_watcher.flow_log.enabled

  retention_policy {
    enabled = var.network_watcher.flow_log.retention_policy.enabled
    days    = var.network_watcher.flow_log.retention_policy.days
  }

  traffic_analytics {
    enabled               = var.network_watcher.flow_log.traffic_analytics.enabled
    workspace_id          = var.log_analytics.workspace_id
    workspace_region      = var.log_analytics.workspace_location
    workspace_resource_id = var.log_analytics.resource_id
    interval_in_minutes   = var.network_watcher.flow_log.traffic_analytics.interval_in_minutes
  }
}