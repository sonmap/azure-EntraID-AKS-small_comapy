locals {
  namespaces_raw   = csvdecode(file("${path.module}/data/namespaces.csv"))
  roles_raw        = csvdecode(file("${path.module}/data/roles.csv"))
  rolebindings_raw = csvdecode(file("${path.module}/data/rolebindings.csv"))

  namespaces = {
    for n in local.namespaces_raw : n.namespace => n
    if lower(n.enabled) == "true"
  }

  enabled_role_rules = [
    for r in local.roles_raw : r
    if lower(r.enabled) == "true"
  ]

  roles = {
    for r in local.enabled_role_rules : "${r.namespace}/${r.role_name}" => r...
  }

  rolebindings = {
    for rb in local.rolebindings_raw : "${rb.namespace}/${rb.binding_name}" => rb
    if lower(rb.enabled) == "true"
  }
}
