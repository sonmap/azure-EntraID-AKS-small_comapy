resource "random_password" "initial" {
  for_each = var.create_users ? local.users : {}

  length           = var.default_password_length
  special          = true
  override_special = "!@#$%*-_=+?"
}

resource "azuread_user" "users" {
  for_each = var.create_users ? local.users : {}

  user_principal_name   = each.value.user_principal_name
  display_name          = each.value.display_name
  given_name            = each.value.given_name
  surname               = each.value.surname
  mail_nickname         = each.value.mail_nickname
  password              = random_password.initial[each.key].result
  force_password_change = var.force_password_change
  account_enabled       = each.value.account_enabled
  usage_location        = each.value.usage_location
  department            = each.value.department
  job_title             = each.value.job_title
}
