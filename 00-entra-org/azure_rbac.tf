resource "azurerm_role_assignment" "azure_rbac" {
  for_each = var.enable_subscription_rbac ? local.enabled_azure_rbac : {}

  scope                = local.role_assignment_scopes[each.key]
  role_definition_name = each.value.role_definition_name
  principal_id         = azuread_group.groups[each.value.group_name].object_id
  principal_type       = "Group"

  depends_on = [
    azuread_group.groups
  ]
}
