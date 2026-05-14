variable "name" {
  type = string
}

variable "domain" {
  type = string
}

variable "server_ids" {
  type = list(number)
}

variable "server_ips" {
  type = list(string)
}

variable "ssh_allowed_cidrs" {
  type    = list(string)
  default = ["0.0.0.0/0", "::/0"]
  # TODO: lock this down to office/VPN IPs in production
}
