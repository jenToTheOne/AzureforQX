variable "resource_group_location" {
  type        = string
  description = "Location for all resources."
  default     = "westus2"
}

variable "dns-locations" {
  default = [ "westus2" ]
}

variable "dns-vnets" {
  default = [ "10.100.0.0/16" ]
}

variable "dns-subnets" {
  default = [ "10.100.0.0/24" ]
}

variable "hub_address_prefix" {
 default  = "10.20.0.0/23"
}

variable "spoke_vnet_1_address_space" {
    default = ["10.10.0.0/16"]
}

variable "workload_subnet_1_address_space" {
    default = ["10.10.1.0/24"]
}

variable "resource_group_name_prefix" {
  type = string
  description = "Prefix for the Resource Group Name that's combined with a random id so name is unique in your Azure subcription."  
  default = "rg"
}

variable "firewall_sku_name" {
  type        = string
  description = "SKU name for the firewall."
  default     = "Premium" # Valid values are Standard and Premium
}

variable "virtual_machine_size" {
  type        = string
  description = "Size of the virtual machine."
  default     = "Standard_D2_v3"
}

variable "admin_username" {
  default = "azureuser"
}