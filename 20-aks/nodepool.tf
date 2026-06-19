resource "azurerm_kubernetes_cluster_node_pool" "user_pools" {
  for_each = local.nodepools

  name                  = each.value.node_pool_name
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks[each.value.cluster_name].id
  mode                  = each.value.mode
  vm_size               = each.value.vm_size
  os_disk_size_gb       = each.value.os_disk_size_gb
  vnet_subnet_id        = data.azurerm_subnet.subnets["${each.value.network_rg}|${each.value.vnet_name}|${each.value.subnet_name}"].id

  auto_scaling_enabled = each.value.enable_auto_scaling
  node_count           = each.value.enable_auto_scaling ? null : each.value.node_count
  min_count            = each.value.enable_auto_scaling ? each.value.min_count : null
  max_count            = each.value.enable_auto_scaling ? each.value.max_count : null

  tags = {
    managed_by = "terraform"
  }

  depends_on = [
    azurerm_kubernetes_cluster.aks
  ]
}
