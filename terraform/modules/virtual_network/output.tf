output "vnet_id" {
  description = "The ID of the virtual network."
  value       = azurerm_virtual_network.vnet.id
}

output "subnet_ids" {
  description = "A map of subnet names to their IDs."
  value       = { for k, v in azurerm_subnet.subnet : k => v.id }
}
