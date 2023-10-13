resource "ssh_resource" "ssh_host" {

  host        = var.hosts.host
  user        = var.hosts.user
  private_key = file("${var.hosts.private_key}")

  timeout     = "15m"
  retry_delay = "5s"

  commands = [
    "sudo snap install docker",
  ]
}