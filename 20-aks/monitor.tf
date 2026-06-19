resource "azurerm_log_analytics_workspace" "law" {
  for_each = local.monitors

  name                = each.value.monitor_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = each.value.retention_in_days

  tags = {
    managed_by = "terraform"
  }

  depends_on = [
    azurerm_resource_group.rg
  ]
}
