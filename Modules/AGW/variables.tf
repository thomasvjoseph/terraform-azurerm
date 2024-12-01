variable "location" {
  type        = string
  description = "The location of the resource in Azure"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which the container registry will be created"
}

variable "subnet_id" {
  type        = string
  description = "The Subnet"
}

variable "fqdns" {
  type        = list(string)
  description = "The fqdns"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to assign to the resource."
}