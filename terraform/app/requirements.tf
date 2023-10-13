resource "docker_container" "postgres" {
  image   = docker_image.postgres.name
  name    = "postgres_db"
  restart = "always"
  env     = ["POSTGRES_PASSWORD=your_password"]
  command = ["postgres", "-c", "config_file=/etc/postgresql/custom.conf"]
  volumes {

    host_path      = "/config/postgres/custom.conf"
    container_path = "/etc/postgresql/"
  }

  networks_advanced {
    name = docker_network.app_network.name
  }
  depends_on = [ssh_resource.ssh_host]
}

resource "docker_container" "redis" {
  image   = docker_image.redis.name
  name    = "redis_server"
  restart = "always"
  volumes {

    host_path      = "/config/redis/custom.conf"
    container_path = "/etc/redis/"
  }
  networks_advanced {
    name = docker_network.app_network.name
  }
}

resource "docker_container" "nginx" {
  image   = docker_image.nginx.name
  name    = "nginx_server"
  restart = "always"
  ports {
    internal = "80"
    external = "80"
  }

  volumes {

    host_path      = "/config/nginx/custom.conf"
    container_path = "/etc/nginx/"
  }
  networks_advanced {
    name = docker_network.app_network.name
  }
}

