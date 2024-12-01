variable "location" {
  type        = string
  description = "The location of the resource in Azure"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which the container registry will be created"
}

variable "redis_cache_name" {
  type        = string
  description = "The name of the redis cache"
}

variable "capacity" {
  type        = number
  description = "The capacity of the redis cache"
  default     = 2
}

variable "family" {
  type        = string
  description = "The family of the redis cache"
  default     = "C"
  validation {
    condition     = contains(["C", "P"], var.family)
    error_message = "The family must be one of 'C' or 'P'."
  }
}

variable "sku_name" {
  type        = string
  description = "The sku name of the redis cache"
  default     = "Basic"
  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.sku_name)
    error_message = "The sku name must be one of 'Basic', 'Standard', or 'Premium'."
  }
}

variable "shard_count" {
  type        = number
  description = "The shard count of the redis cache"
  default     = 1
}

variable "non_ssl_port_enabled" {
  type        = bool
  description = "Indicates whether the non-ssl port is enabled"
  default     = false
}

variable "minimum_tls_version" {
  type        = string
  description = "The minimum TLS version"
  default     = "1.2"
  validation {
    condition     = contains(["1.0", "1.1", "1.2"], var.minimum_tls_version)
    error_message = "The minimum TLS version must be one of '1.0', '1.1', or '1.2'."
  }
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Indicates whether public network access is enabled"
  default     = true
  validation {
    condition     = contains([true, false], var.public_network_access_enabled)
    error_message = "The public network access must be either true or false."
  }
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to assign to the resource."
}