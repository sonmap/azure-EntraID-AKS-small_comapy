output "created_user_count" {
  value = length(azuread_user.users)
}

output "created_group_count" {
  value = length(azuread_group.groups)
}

output "group_object_ids" {
  value = {
    for name, group in azuread_group.groups : name => group.object_id
  }
}

output "aks_tfvars_object_ids" {
  value = {
    aks_admin_group_object_ids = [
      azuread_group.groups["SG-AZ-PLATFORM-ADMINS"].object_id
    ]

    platform_admin_group_object_id = azuread_group.groups["SG-AZ-PLATFORM-ADMINS"].object_id
    aks_operator_group_object_id   = azuread_group.groups["SG-AZ-AKS-OPERATORS"].object_id
    aks_developer_group_object_id  = azuread_group.groups["SG-AZ-AKS-DEV-DEVELOPERS"].object_id
    aks_reader_group_object_id     = azuread_group.groups["SG-AZ-AKS-READERS"].object_id
    security_ops_group_object_id   = azuread_group.groups["SG-AZ-SECURITY-OPS"].object_id
  }
}

output "initial_passwords_sensitive" {
  sensitive = true
  value = {
    for k, p in random_password.initial : local.users[k].user_principal_name => p.result
  }
}
