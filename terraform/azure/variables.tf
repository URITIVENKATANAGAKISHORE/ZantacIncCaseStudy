variable "environment" {
  type        = string
  description = "Deployment environment (e.g., dev, prod)"
}
variable "resource_group_name" {
  type        = string
  description = "Name of the Azure resource group"
}
variable "location" {
  type        = string
  description = "Azure region for resource deployment"
}
variable "vnet_cidr" {
  type        = string
  description = "CIDR block for the virtual network"
}
variable "subnet_cidr" {
  type        = string
  description = "CIDR block for the subnet"
}
variable "vm_size" {
  type        = string
  description = "Size of the virtual machine (e.g., Standard_DS1_v2)"
}
variable "admin_username" {
  type        = string
  description = "Admin username for the VM"
}
variable "instance_count" {
  type        = number
  description = "Number of VM instances to deploy"
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
variable "web_server_port" {
  type        = number
  description = "Port number for the web server"
}
variable "allowed_cidr" {
  type        = string
  description = "CIDR block allowed to access resources"
}
variable "aad_user_object_id" {
  type        = string
  description = "Azure Active Directory user object ID for access control"
}
variable "tenant_id" {
  type        = string
  description = "Azure Active Directory tenant ID"
}
variable "admin_object_id" {
  type        = string
  description = "Object ID of the admin user in Azure AD"
}
