variable "db_name" {
  description = "The database name which u will create during creating db cluster"
  type        = string
}

variable "db_admin_username" {
  description = "The admin username for created database"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "Just for example so input password from environment variable"
  type        = string
  # you will need set TF_VAR_db_password="xxx"
}

variable "db_cluster_name" {
  description = "The Database cluster name"
  type        = string
}

variable "db_engine" {
  description = "The database engine name for the db cluster"
  type        = string
}

variable "db_storage_size" {
  description = "The database allocated storage size, default using 10G"
  type        = number
  default     = 10
}

variable "db_instance_type" {
  description = "The database instance type"
  type        = string
  default     = "db.t2.micro"
}