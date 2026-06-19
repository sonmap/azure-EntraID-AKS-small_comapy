resource "azurerm_subnet" "subnet" {
  for_each = local.subnets

  name                 = each.value.subnet_name
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.vnet_name
  address_prefixes     = split("|", each.value.address_prefixes)

  depends_on = [
    azurerm_virtual_network.vnet
  ]
}
