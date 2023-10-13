resource "docker_image" "postgres" {
  name = var.postgres_image
}

resource "docker_image" "redis" {
  name = var.redis_image
}

resource "docker_image" "nginx" {
  name = var.nginx_image
}