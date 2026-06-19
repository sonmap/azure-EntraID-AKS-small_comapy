output "namespaces" {
  value = keys(kubernetes_namespace_v1.ns)
}

output "rolebindings" {
  value = {
    for k, rb in kubernetes_role_binding_v1.bindings : k => rb.metadata[0].name
  }
}
