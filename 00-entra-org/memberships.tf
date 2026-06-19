resource "azuread_group_member" "memberships" {
  for_each = var.create_group_memberships ? local.memberships : {}

  group_object_id  = azuread_group.groups[each.value.group_name].object_id
  member_object_id = azuread_user.users[each.value.user_key].object_id

  depends_on = [
    azuread_group.groups,
    azuread_user.users
  ]
}
