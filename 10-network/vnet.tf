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

resource "azurerm_virtual_network" "vnet" {
  for_each = local.vnets

  name                = each.value.vnet_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  address_space       = split("|", each.value.address_space)

  dns_servers = length(trimspace(each.value.dns_servers)) > 0 ? split("|", each.value.dns_servers) : null

  tags = {
    managed_by  = "terraform"
    description = each.value.description
  }

  depends_on = [
    azurerm_resource_group.rg
  ]
}
