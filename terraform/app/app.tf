# Custom Application Container
resource "docker_container" "web_app" {
  image   = "image_registry_path:${var.app_tag}"
  name    = "web_app_container"
  restart = "always"
  ports {
    internal = 8000
    ip       = "127.0.0.1"
    external = 8000
  }
  networks_advanced {
    name = docker_network.app_network.name
  }

  depends_on = [
    docker_container.postgres,
    docker_container.redis,
    docker_container.nginx,
  ]
}

