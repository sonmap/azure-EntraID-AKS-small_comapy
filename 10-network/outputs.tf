output "resource_group_names" {
  value = keys(azurerm_resource_group.rg)
}

output "vnet_ids" {
  value = {
    for name, vnet in azurerm_virtual_network.vnet : name => vnet.id
  }
}

output "subnet_ids" {
  value = {
    for key, subnet in azurerm_subnet.subnet : key => subnet.id
  }
}

output "next_step_20_aks_network_reference" {
  value = {
    network_resource_group = "rg-ai-network-krc"
    vnet_name              = "vnet-ai-dev-krc"
    aks_system_subnet_name = "snet-aks-system"
    aks_user_subnet_name   = "snet-aks-user"
  }
}
