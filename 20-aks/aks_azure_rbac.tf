resource "azurerm_role_assignment" "aks_azure_rbac" {
  for_each = var.enable_aks_azure_rbac_assignments ? local.enabled_aks_azure_rbac : {}

  scope                = azurerm_kubernetes_cluster.aks[each.value.cluster_name].id
  role_definition_name = each.value.role_definition_name
  principal_id         = var.entra_group_object_ids[each.value.group_name]
  principal_type       = "Group"

  depends_on = [
    azurerm_kubernetes_cluster.aks
  ]
}
