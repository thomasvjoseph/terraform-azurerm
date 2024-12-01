variable "location" {
  type        = string
  description = "The location of the resource in Azure"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which the container registry will be created"
}

variable "acr_name" {
  type        = string
  description = "The name of the container registry"
}

variable "sku" {
  type        = string
  description = "The SKU of the Azure Container Registry (Basic, Standard, Premium)"
  default     = "Basic"
  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.sku)
    error_message = "The SKU must be one of 'Basic', 'Standard', or 'Premium'."
  }
}

variable "admin_enabled" {
  type        = bool
  description = "Whether the Container Registry is enabled for public access."
  default     = false
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Whether the Container Registry is accessible publicly."
  default     = true
}

variable "azure_services_bypass_allowed" {
  type        = bool
  description = "Whether to allow trusted Azure services to access a network restricted Container Registry."
  default     = false
}

variable "data_endpoint_enabled" {
  type        = bool
  description = "Whether to enable dedicated data endpoints for this Container Registry? (Only supported on resources with the Premium SKU)."
  default     = true
}

/* variable "allowed_cidrs" {
  type        = list(string)
  description = "List of CIDRs to allow on the registry."
  default     = []
}

variable "allowed_subnets" {
  type        = list(string)
  description = "List of VNet/Subnet IDs to allow on the registry."
  default     = []
} */