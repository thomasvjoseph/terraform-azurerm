variable "location" {
  type        = string
  description = "The location of the resource in Azure"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which the container registry will be created"
}

variable "c_app_env_name" {
  type        = string
  description = "The name of the container app environment"
}

variable "log_analytics_workspace_id" {
  type        = string
  description = "The ID of the log analytics workspace"
}

variable "subnet_id" {
  type        = string
  description = "The Subnet"
  default     = null
}

variable "container_app_name" {
  type        = string
  description = "The name of the container app"
}

variable "ingress_enabled" {
  type        = bool
  description = "Indicates if the container app is enabled for ingress"
  #Setting external_enabled to false indeed limits access to the “Container Apps Environment” (meaning the VNet it is attached to, if configured)
  #With this setup, your Application Gateway can manage the public ingress while the Container App only accepts traffic from the Application Gateway within the VNet.
  default = false
  validation {
    condition     = var.ingress_enabled == true || var.ingress_enabled == false
    error_message = "The ingress must be either true or false."
  }
}

variable "app_gateway_subnet_cidr" {
  type        = string
  description = "The CIDR of the app gateway subnet"
}
