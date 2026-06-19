output "aks_cluster_ids" {
  value = {
    for name, aks in azurerm_kubernetes_cluster.aks : name => aks.id
  }
}

output "aks_resource_group_names" {
  value = {
    for name, aks in azurerm_kubernetes_cluster.aks : name => aks.resource_group_name
  }
}

output "acr_ids" {
  value = {
    for name, acr in azurerm_container_registry.acr : name => acr.id
  }
}

output "next_step_30_aks_rbac" {
  value = {
    kube_config_command = "az aks get-credentials -g rg-ai-aks-krc -n aks-ai-dev-krc --overwrite-existing"
    kube_context        = "aks-ai-dev-krc"
    cluster_name        = "aks-ai-dev-krc"
  }
}
