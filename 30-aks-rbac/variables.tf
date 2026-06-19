variable "kube_config_path" {
  description = "Path to kubeconfig. Run az aks get-credentials before apply."
  type        = string
  default     = "~/.kube/config"
}

variable "kube_config_context" {
  description = "Kubernetes context name."
  type        = string
  default     = "aks-ai-dev-krc"
}

variable "entra_group_object_ids" {
  description = "Map of Entra group display name to object ID from 00-entra-org output."
  type        = map(string)
}
