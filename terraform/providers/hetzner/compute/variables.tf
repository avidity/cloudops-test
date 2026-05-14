variable "name"               { type = string }
variable "env"                { type = string }
variable "private_network_id" { type = number }

variable "region" {
  type    = string
  default = "nbg1"
}

variable "instance_count" {
  type    = number
  default = 1
}

variable "size_class" {
  type    = string
  default = "cx22"
}

variable "db_size_class" {
  type    = string
  default = "cx22"
}

variable "app_storage_gb" {
  type    = number
  default = 50
}

variable "db_storage_gb" {
  type    = number
  default = 100
}

variable "ssh_public_key" {
  type      = string
  sensitive = true
}
