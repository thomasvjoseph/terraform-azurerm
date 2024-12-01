variable "location" {
  type        = string
  description = "The location of the resource in Azure"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which the container registry will be created"
}

variable "key_vault_name" {
  type        = string
  description = "The name of the key vault"
}

variable "soft_delete_retention_days" {
  type        = number
  description = "The number of days that items should be retained for once soft-deleted"
  default     = 7
}

variable "enabled_for_disk_encryption" {
  type        = bool
  description = "Indicates if the key vault is enabled for disk encryption"
  default     = false
}

variable "purge_protection_enabled" {
  type        = bool
  description = "Indicates if the key vault is enabled for purge protection"
  default     = false
}

variable "sku_name" {
  type        = string
  description = "The name of the key vault"
  default     = "standard"
  validation {
    condition     = contains(["standard", "premium"], var.sku_name)
    error_message = "The sku name must be one of 'standard' or 'premium'."
  }
}

variable "access_policies" {
  description = "Access policies for the key vault"
  type = object({
    object_id           = string
    key_permissions     = optional(list(string))
    secret_permissions  = optional(list(string))
    storage_permissions = optional(list(string))
  })
  default = null
}

variable "network_acls" {
  description = "Network ACLs for the key vault"
  type = object({
    bypass                     = string
    default_action             = string
    virtual_network_subnet_ids = list(string)
    ip_rules                   = optional(list(string))
  })
  default = null
}
variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to assign to the resource."
}