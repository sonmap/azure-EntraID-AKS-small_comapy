resource "azuread_group" "groups" {
  for_each = var.create_groups ? local.groups : {}

  display_name             = each.value.group_name
  description              = each.value.description
  security_enabled         = each.value.security_enabled
  mail_enabled             = each.value.mail_enabled
  prevent_duplicate_names  = true
}
