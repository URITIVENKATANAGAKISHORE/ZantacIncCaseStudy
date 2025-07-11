variable "resource_group_name" {
  type        = string
  description = "Name of the Azure resource group"
}
variable "location" {
  type        = string
  description = "Azure region for resource deployment"
}
variable "vnet_name" {
  type        = string
  description = "Name of the virtual network"
}
variable "vnet_address_space" {
  type        = list(string)
  description = "Address space for the virtual network"
}
variable "subnet_name" {
  type        = string
  description = "Name of the subnet"
}
variable "subnet_address_prefixes" {
  type        = list(string)
  description = "Address prefixes for the subnet"
}
variable "nsg_name" {
  type        = string
  description = "Name of the network security group"
}
variable "public_ip_name" {
  type        = string
  description = "Name of the public IP address"
}
variable "lb_name" {
  type        = string
  description = "Name of the load balancer"
}
variable "vmss_name" {
  type        = string
  description = "Name of the virtual machine scale set"
}
variable "vmss_sku" {
  type        = string
  description = "SKU for the virtual machine scale set"
}
variable "vmss_instance_count" {
  type        = number
  description = "Number of VMSS instances to deploy"
}
variable "admin_username" {
  type        = string
  description = "Admin username for the VMSS"
}
variable "image_publisher" {
  type        = string
  description = "Publisher of the VM image"
}
variable "image_offer" {
  type        = string
  description = "Offer of the VM image"
}
variable "image_sku" {
  type        = string
  description = "SKU of the VM image"
}
variable "image_version" {
  type        = string
  description = "Version of the VM image"
}
variable "key_vault_name" {
  type        = string
  description = "Name of the Azure Key Vault"
}
variable "tenant_id" {
  type        = string
  description = "Azure Active Directory tenant ID"
}
variable "admin_object_id" {
  type        = string
  description = "Object ID of the admin user in Azure AD"
}
