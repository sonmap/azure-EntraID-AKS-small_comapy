locals {
  users_raw             = csvdecode(file("${path.module}/data/users.csv"))
  groups_raw            = csvdecode(file("${path.module}/data/groups.csv"))
  memberships_raw       = csvdecode(file("${path.module}/data/group_memberships.csv"))
  azure_rbac_raw        = csvdecode(file("${path.module}/data/azure_rbac.csv"))
  aks_rbac_raw          = csvdecode(file("${path.module}/data/aks_rbac.csv"))

  users = {
    for u in local.users_raw : u.user_key => merge(u, {
      account_enabled       = lower(u.account_enabled) == "true"
      force_password_change = lower(u.force_password_change) == "true"
      user_principal_name   = length(regexall("@", u.user_principal_name)) > 0 ? u.user_principal_name : "${u.user_principal_name}@${var.user_domain}"
    })
  }

  groups = {
    for g in local.groups_raw : g.group_name => merge(g, {
      security_enabled = lower(g.security_enabled) == "true"
      mail_enabled     = lower(g.mail_enabled) == "true"
    })
  }

  memberships = {
    for m in local.memberships_raw : "${m.user_key}|${m.group_name}" => m
  }

  enabled_azure_rbac = {
    for idx, r in local.azure_rbac_raw : "${idx}-${r.group_name}-${r.role_definition_name}" => r
    if lower(r.enabled) == "true"
  }

  subscription_scope = "/subscriptions/${var.subscription_id}"

  role_assignment_scopes = {
    for k, r in local.enabled_azure_rbac : k => (
      r.scope_type == "subscription" ? local.subscription_scope :
      r.scope_type == "resource_group" ? "${local.subscription_scope}/resourceGroups/${r.resource_group_name}" :
      r.scope_resource_id
    )
  }
}
