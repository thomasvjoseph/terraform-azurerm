variable "resource_group_location" {
  type        = string
  default     = "East US 2"
  description = "Location of the resource group."
}

variable "resource_group_name_prefix" {
  type        = string
  default     = "test-resource-group"
  description = "Prefix of the resource group name, so name is unique in your Azure subscription."
}

variable "client_id" {
  type        = string
  description = "Client ID of the service principal"
  sensitive   = true
}
variable "client_secret" {
  type        = string
  description = "Client Secret of the service principal"
  sensitive   = true
}
variable "tenant_id" {
  type        = string
  description = "Tenant ID of the service principal"
  sensitive   = true
}
variable "subscription_id" {
  type        = string
  description = "Subscription ID of the service principal"
  sensitive   = true
}