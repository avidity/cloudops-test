terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.47"
    }
  }
}

resource "hcloud_server" "this" {
  count       = var.instance_count
  name        = "${var.name}-${count.index + 1}"
  image       = "debian-12"
  server_type = var.server_type
  location    = var.location
  ssh_keys    = [hcloud_ssh_key.deploy.id]
  user_data   = file("${path.module}/cloud-init.yml")

  labels = {
    env  = var.env
    role = "app"
  }

  lifecycle {
    prevent_destroy       = var.prevent_destroy
    ignore_changes        = [user_data]
    create_before_destroy = true
  }
}

resource "hcloud_ssh_key" "deploy" {
  name       = "${var.name}-deploy"
  public_key = var.ssh_public_key
}

resource "hcloud_volume" "storage" {
  count    = var.instance_count
  name     = "${var.name}-storage-${count.index + 1}"
  size     = var.storage_size_gb
  server_id = hcloud_server.this[count.index].id
  automount = true
  format    = "ext4"
}
