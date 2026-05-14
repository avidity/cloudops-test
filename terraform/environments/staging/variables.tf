variable "hcloud_token" {
  type      = string
  sensitive = true
}

variable "ssh_public_key" {
  type      = string
  sensitive = true
}

variable "domain" {
  type    = string
  default = "staging.example.com"
}
