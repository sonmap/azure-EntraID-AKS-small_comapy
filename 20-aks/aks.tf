resource "azurerm_kubernetes_cluster" "aks" {
  for_each = local.aks_clusters

  name                = each.value.cluster_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  dns_prefix          = each.value.dns_prefix
  kubernetes_version  = length(trimspace(each.value.kubernetes_version)) > 0 ? each.value.kubernetes_version : null
  sku_tier            = each.value.sku_tier

  private_cluster_enabled = each.value.private_cluster_enabled

  role_based_access_control_enabled = true

  azure_active_directory_role_based_access_control {
    tenant_id              = var.tenant_id
    admin_group_object_ids = var.aks_admin_group_object_ids
    azure_rbac_enabled     = true
  }

  default_node_pool {
    name                 = each.value.system_node_pool_name
    vm_size              = each.value.system_node_vm_size
    node_count           = each.value.system_node_count
    vnet_subnet_id       = data.azurerm_subnet.subnets["${each.value.network_rg}|${each.value.vnet_name}|${each.value.system_subnet_name}"].id
    only_critical_addons_enabled = true
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin      = "azure"
    network_plugin_mode = "overlay"
    network_policy      = "azure"
    load_balancer_sku   = "standard"
    outbound_type       = "loadBalancer"
  }

  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.law[each.value.monitor_name].id
  }

  tags = {
    managed_by = "terraform"
  }

  depends_on = [
    azurerm_resource_group.rg,
    azurerm_log_analytics_workspace.law
  ]
}

resource "azurerm_role_assignment" "acr_pull" {
  for_each = local.aks_clusters

  scope                = azurerm_container_registry.acr[each.value.acr_name].id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks[each.key].kubelet_identity[0].object_id
}
