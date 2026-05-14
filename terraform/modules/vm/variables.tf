variable "name" {
  description = "Base name for resources"
  type        = string
}

variable "env" {
  type = string
}

variable "instance_count" {
  type    = number
  default = 1
}

variable "server_type" {
  type    = string
  default = "cx22"  # 2 vCPU, 4GB
}

variable "location" {
  type    = string
  default = "nbg1"  # Nuremberg — lowest latency for EU
}

variable "ssh_public_key" {
  type      = string
  sensitive = true
}

variable "storage_size_gb" {
  type    = number
  default = 50
}

variable "prevent_destroy" {
  type    = bool
  default = false
}
