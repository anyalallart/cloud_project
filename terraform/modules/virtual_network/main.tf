resource "azurerm_virtual_network" "vnet" {
  name                = "${var.name}-vnet"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
}

resource "azurerm_subnet" "subnet" {
  for_each = var.subnets

    name                 = each.key
    resource_group_name  = var.resource_group_name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes     = each.value.address_prefixes

    dynamic "delegation" {
      for_each = each.value.delegation != null ? [each.value.delegation] : []
      content {
        name = "delegation-${each.key}"
        service_delegation {
          name = each.value.delegation
          actions = [
            "Microsoft.Network/virtualNetworks/subnets/action"
          ]
        }
      }
    }
}
