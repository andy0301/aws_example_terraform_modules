variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 8080
}

variable "cluster_name" {
  description = "The name to use for all cluster resources"
  type        = string
}

variable "db_remote_state_bucket" {
  description = "The name of S3 bucket for database's remote state"
  type        = string
}

variable "db_remote_state_key" {
  description = "The terraform state file path for the database's remote state in S3"
  type        = string
}

variable "region" {
  description = "Region name"
  type        = string
}

variable "vm_type" {
  description = "VM type for creating VM instances"
  type        = string
}

variable "autoscale_min_size" {
  description = "The minimum number of autoscalling size"
  type        = number
}

variable "autoscale_max_size" {
  description = "The maximum number of autoscalling size"
  type        = number
}