resource "azurerm_resource_group" "rg" {
  for_each = local.resource_groups

  name     = each.value.resource_group_name
  location = each.value.location

  tags = {
    environment = each.value.environment
    owner       = each.value.owner
    managed_by  = "terraform"
  }
}

resource "azurerm_container_registry" "acr" {
  for_each = local.acrs

  name                = each.value.acr_name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  sku                 = each.value.sku
  admin_enabled       = each.value.admin_enabled

  tags = {
    managed_by = "terraform"
  }

  depends_on = [
    azurerm_resource_group.rg
  ]
}
