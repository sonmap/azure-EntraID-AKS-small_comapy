data "azurerm_subnet" "subnets" {
  for_each = local.subnet_ref_strings

  name                 = split("|", each.value)[2]
  virtual_network_name = split("|", each.value)[1]
  resource_group_name  = split("|", each.value)[0]
}
