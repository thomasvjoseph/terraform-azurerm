variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which the container registry will be created"
}

variable "location" {
  type        = string
  description = "The location of the resource in Azure"
}

variable "private_endpoint" {
  type = map(object({
    private_endpoint_name             = string
    subnet_id                         = string
    private_service_connection_name   = string
    private_connection_resource_alias = optional(string)
    private_connection_resource_id    = optional(string)
    request_message                   = optional(string)
    
  }))
  description = "The name of the resource group in which the container registry will be created"
}

variable "subresource_names" {
  type        = list(string)
  description = "The subresource names"
  default     = ["redisCache"]
}

variable "is_manual_connection" {
  type        = bool
  description = "Indicates whether the private endpoint is manually connected"
  default     = false
  validation {
    condition     = contains([true, false], var.is_manual_connection)
    error_message = "The is_manual_connection must be true or false."
  }
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to assign to the resource."
}