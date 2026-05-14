variable "name"                  { type = string }
variable "env"                   { type = string }
variable "ssh_public_key"        { type = string; sensitive = true }
variable "region"                { type = string; default = "eu-north-1" }
variable "instance_count"        { type = number; default = 1 }
variable "size_class"            { type = string; default = "t3.small" }
variable "db_size_class"         { type = string; default = "t3.small" }
variable "app_storage_gb"        { type = number; default = 50 }
variable "db_storage_gb"         { type = number; default = 100 }
variable "prevent_destroy"       { type = bool;   default = false }
variable "app_subnet_id"         { type = string }
variable "db_subnet_id"          { type = string }
variable "app_security_group_id" { type = string }
variable "db_security_group_id"  { type = string }
