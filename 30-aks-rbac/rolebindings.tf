resource "kubernetes_role_binding_v1" "bindings" {
  for_each = local.rolebindings

  metadata {
    name      = each.value.binding_name
    namespace = each.value.namespace
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = each.value.role_name
  }

  subject {
    kind      = "Group"
    name      = var.entra_group_object_ids[each.value.group_name]
    api_group = "rbac.authorization.k8s.io"
  }

  depends_on = [
    kubernetes_role_v1.roles
  ]
}
