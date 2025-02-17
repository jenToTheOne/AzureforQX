resource "azurerm_virtual_network" "spoke_vnet_1" {
  name                = "vnet-spoke-securehub-weus-1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = var.spoke_vnet_1_address_space
}

resource "azurerm_subnet" "workload_subnet_1" {
  name                 = "subnet-workload-1"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.spoke_vnet.name
  address_prefixes     = var.workload_subnet_1_address_space
}

resource "azurerm_network_interface" "vm_workload_nic" {
  name                = "nic-workload"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ipconfig-workload"
    subnet_id                     = azurerm_subnet.workload_subnet_1.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_security_group" "workload_nsg" {
  name                = "nsg-workload"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_network_interface_security_group_association" "workload_nsg_association" {
  network_interface_id      = azurerm_network_interface.vm_workload_nic.id
  network_security_group_id = azurerm_network_security_group.workload_nsg.id
}

resource "azurerm_virtual_hub_connection" "azfw_vwan_hub_connection" {
  name                      = "hub-to-spoke"
  virtual_hub_id            = azurerm_virtual_hub.azfw_vwan_hub_westus.id
  remote_virtual_network_id = azurerm_virtual_network.spoke_vnet.id
  internet_security_enabled = true
}