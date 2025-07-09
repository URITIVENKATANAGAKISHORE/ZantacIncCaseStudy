variable "resource_group_name" {}
variable "location" {}
variable "vnet_name" {}
variable "vnet_address_space" { type = list(string) }
variable "subnet_name" {}
variable "subnet_address_prefixes" { type = list(string) }
variable "nsg_name" {}
variable "public_ip_name" {}
variable "lb_name" {}
variable "vmss_name" {}
variable "vmss_sku" {}
variable "vmss_instance_count" { type = number }
variable "admin_username" {}
variable "image_publisher" {}
variable "image_offer" {}
variable "image_sku" {}
variable "image_version" {}
variable "key_vault_name" {}
variable "tenant_id" {}
variable "admin_object_id" {}
