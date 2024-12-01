variable "PostgreSQL_name" {
  type        = string
  description = "The name of the PostgreSQL server"
}

variable "location" {
  type        = string
  description = "The location of the resource in Azure"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which the container registry will be created"
}

variable "PostgreSQL_version" {
  type        = string
  description = "The version of PostgreSQL to use"
  default     = "11"
  validation {
    condition     = contains(["9.5", "9.6", "10", "11", "12", "13"], var.PostgreSQL_version)
    error_message = "The PostgreSQL version must be one of '9.5', '9.6', '10', '11', '12', or '13'."
  }
}

variable "public_access_enabled" {
  description = "Indicates if the server is public (true) or private (false)."
  type        = bool
  default     = false
}

variable "PostgreSQL_delegated_subnet_id" {
  type        = string
  description = "The ID of the delegated subnet"
  default     = null
}

variable "PostgreSQL_private_dns_zone_id" {
  type        = string
  default     = null
  description = "The ID of the private DNS zone"
}

variable "PostgreSQL_administrator_login" {
  type        = string
  description = "The administrator login for the PostgreSQL server"
}

variable "PostgreSQL_administrator_password" {
  type        = string
  description = "The administrator password for the PostgreSQL server"
}

/* variable "PostgreSQL_availability_zone" {
  type        = string
  default     = ""
  description = "The availability zone for the PostgreSQL server"
  validation {
    condition     = contains(["Zone-1", "Zone-2", "Zone-3"], var.PostgreSQL_availability_zone)
    error_message = "The availability zone must be one of 'Zone-1', 'Zone-2', or 'Zone-3'."
  }
} */

variable "PostgreSQL_backup_retention_days" {
  type        = number
  description = "The backup retention days for the PostgreSQL server"
  default     = 7
}

variable "storage_mb" {
  type        = number
  description = "The storage in MB for the PostgreSQL server"
  default     = 32768
}

variable "storage_tier" {
  type        = string
  description = "The storage tier for the PostgreSQL server"
  default     = "P4"
}

variable "PostgreSQL_auto_grow_enabled" {
  type        = bool
  description = "Whether the PostgreSQL server has auto grow enabled"
  default     = false
}

variable "PostgreSQL_sku_name" {
  type        = string
  description = "The SKU name for the PostgreSQL server"
  default     = "B_Standard_B1ms"
}

variable "PostgreSQL_maintenance_window_day_of_week" {
  type        = number
  description = "The day of the week for the maintenance window"
  default     = 1

}

variable "PostgreSQL_maintenance_window_start_hour" {
  type        = number
  description = "The start hour for the maintenance window"
  default     = 0
}

variable "PostgreSQL_maintenance_window_start_minute" {
  type        = number
  description = "The start minute for the maintenance window"
  default     = 0
}


variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to assign to the resource."
}

variable "PostgreSQL_database_name" {
  type        = string
  description = "The name of the PostgreSQL database"
}

variable "PostgreSQL_database_collation" {
  type        = string
  description = "The collation for the PostgreSQL database"
  default     = "en_US.utf8"
}

variable "PostgreSQL_database_charset" {
  type        = string
  description = "The charset for the PostgreSQL database"
  default     = "utf8"
}