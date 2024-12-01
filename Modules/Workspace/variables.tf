variable "location" {
  type        = string
  description = "The location of the resource in Azure"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which the container registry will be created"
}

variable "log_analytics_workspace_name" {
  type        = string
  description = "The name of the log analytics workspace"
}

variable "log_sku" {
  type        = string
  description = "The SKU of the log analytics workspace"
  default     = "PerGB2018"
}

variable "log_retention_days" {
  type        = number
  description = "The retention in days of the log analytics workspace"
  default     = 30
}