provider "azuread" {
  tenant_id = var.tenant_id
}

provider "azurerm" {
  features {}
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
}
