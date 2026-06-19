resource "kubernetes_namespace_v1" "ns" {
  for_each = local.namespaces

  metadata {
    name = each.value.namespace

    labels = {
      environment = each.value.label_env
      owner       = each.value.label_owner
      managed_by  = "terraform"
    }

    annotations = {
      description = each.value.description
    }
  }
}
