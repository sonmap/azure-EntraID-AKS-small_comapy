variable "tenant_id" {
  description = "Microsoft Entra ID tenant ID."
  type        = string
}

variable "subscription_id" {
  description = "Azure subscription ID."
  type        = string
}

variable "user_domain" {
  description = "UPN domain for created users."
  type        = string
}

variable "create_users" {
  description = "Whether to create Entra ID users from data/users.csv."
  type        = bool
  default     = true
}

variable "create_groups" {
  description = "Whether to create Entra ID groups from data/groups.csv."
  type        = bool
  default     = true
}

variable "create_group_memberships" {
  description = "Whether to create user-to-group memberships from data/group_memberships.csv."
  type        = bool
  default     = true
}

variable "enable_subscription_rbac" {
  description = "Whether to create Azure RBAC assignments from data/azure_rbac.csv."
  type        = bool
  default     = true
}

variable "default_password_length" {
  description = "Random initial password length."
  type        = number
  default     = 20
}

variable "force_password_change" {
  description = "Force users to change password at next sign-in."
  type        = bool
  default     = true
}
