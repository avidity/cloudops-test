variable "name"             { type = string }
variable "region"           { type = string; default = "eu-north-1" }
variable "private_cidr"     { type = string; default = "10.0.0.0/16" }
variable "app_subnet_cidr"  { type = string; default = "10.0.1.0/24" }
variable "db_subnet_cidr"   { type = string; default = "10.0.2.0/24" }
variable "ssh_allowed_cidrs" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}
