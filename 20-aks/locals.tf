locals {
  resource_groups_raw  = csvdecode(file("${path.module}/data/resource_groups.csv"))
  acr_raw              = csvdecode(file("${path.module}/data/acr.csv"))
  monitor_raw          = csvdecode(file("${path.module}/data/monitor.csv"))
  aks_clusters_raw     = csvdecode(file("${path.module}/data/aks_clusters.csv"))
  nodepools_raw        = csvdecode(file("${path.module}/data/nodepools.csv"))
  aks_azure_rbac_raw   = csvdecode(file("${path.module}/data/aks_azure_rbac.csv"))

  resource_groups = {
    for rg in local.resource_groups_raw : rg.resource_group_name => rg
  }

  acrs = {
    for a in local.acr_raw : a.acr_name => merge(a, {
      admin_enabled = lower(a.admin_enabled) == "true"
    })
  }

  monitors = {
    for m in local.monitor_raw : m.monitor_name => merge(m, {
      retention_in_days = tonumber(m.retention_in_days)
    })
  }

  aks_clusters = {
    for c in local.aks_clusters_raw : c.cluster_name => merge(c, {
      private_cluster_enabled = lower(c.private_cluster_enabled) == "true"
      system_node_count      = tonumber(c.system_node_count)
    })
  }

  nodepools = {
    for n in local.nodepools_raw : "${n.cluster_name}/${n.node_pool_name}" => merge(n, {
      node_count          = tonumber(n.node_count)
      min_count           = tonumber(n.min_count)
      max_count           = tonumber(n.max_count)
      os_disk_size_gb     = tonumber(n.os_disk_size_gb)
      enable_auto_scaling = lower(n.enable_auto_scaling) == "true"
    })
  }

  subnet_ref_strings = toset(concat(
    [for c in local.aks_clusters : "${c.network_rg}|${c.vnet_name}|${c.system_subnet_name}"],
    [for n in local.nodepools : "${n.network_rg}|${n.vnet_name}|${n.subnet_name}"]
  ))

  enabled_aks_azure_rbac = {
    for idx, r in local.aks_azure_rbac_raw : "${idx}-${r.cluster_name}-${r.group_name}" => r
    if lower(r.enabled) == "true"
  }
}
