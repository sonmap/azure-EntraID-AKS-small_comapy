resource "kubernetes_role_v1" "roles" {
  for_each = local.roles

  metadata {
    name      = split("/", each.key)[1]
    namespace = split("/", each.key)[0]
  }

  dynamic "rule" {
    for_each = each.value

    content {
      api_groups = length(trimspace(rule.value.api_groups)) > 0 ? split("|", rule.value.api_groups) : [""]
      resources  = split("|", rule.value.resources)
      verbs      = split("|", rule.value.verbs)
    }
  }

  depends_on = [
    kubernetes_namespace_v1.ns
  ]
}
