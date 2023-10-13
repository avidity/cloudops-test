# Variables
variable "app_tag" {
  default = "latest"
}
variable "nginx_image" {
  default     = "nginx:1.10"
  description = "redis docker image version"
  type        = string
}
variable "postgres_image" {
  default     = "postgres:13.12"
  description = "redis docker image version"
  type        = string
}
variable "redis_image" {
  default     = "redis:6.2.13"
  description = "redis docker image version"
  type        = string
}