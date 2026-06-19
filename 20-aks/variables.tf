variable "tenant_id" {
  description = "Microsoft Entra ID tenant ID."
  type        = string
}

variable "subscription_id" {
  description = "Azure subscription ID."
  type        = string
}

variable "aks_admin_group_object_ids" {
  description = "AKS admin Entra group object IDs from 00-entra-org output."
  type        = list(string)
  default     = []
}

variable "entra_group_object_ids" {
  description = "Map of Entra group display name to object ID from 00-entra-org output."
  type        = map(string)
  default     = {}
}

variable "enable_aks_azure_rbac_assignments" {
  description = "Create Azure RBAC assignments for AKS groups from data/aks_azure_rbac.csv."
  type        = bool
  default     = true
}
