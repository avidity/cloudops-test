terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.47"
    }
  }
}

resource "hcloud_ssh_key" "deploy" {
  name       = "${var.name}-deploy"
  public_key = var.ssh_public_key
}

resource "hcloud_server" "app" {
  count       = var.instance_count
  name        = "${var.name}-${count.index + 1}"
  image       = "debian-12"
  server_type = var.size_class
  location    = var.region
  ssh_keys    = [hcloud_ssh_key.deploy.id]
  user_data   = file("${path.module}/cloud-init.yml")
  network {
    network_id = var.private_network_id
  }

  labels = {
    env  = var.env
    role = "app"
  }

  lifecycle {
    prevent_destroy       = true
    ignore_changes        = [user_data]
    create_before_destroy = true
    # To replace a server: terraform state rm module.compute.hcloud_server.app[N]
    # then terraform apply — Terraform limitation: prevent_destroy cannot use variables
  }
}

resource "hcloud_server" "db" {
  name        = "${var.name}-db"
  image       = "debian-12"
  server_type = var.db_size_class
  location    = var.region
  ssh_keys    = [hcloud_ssh_key.deploy.id]
  user_data   = file("${path.module}/cloud-init.yml")
  network {
    network_id = var.private_network_id
  }

  labels = {
    env  = var.env
    role = "db"
  }

  lifecycle {
    prevent_destroy = true
    # To replace: terraform state rm module.compute.hcloud_server.db && terraform apply
  }
}


resource "hcloud_volume" "app_storage" {
  count     = var.instance_count
  name      = "${var.name}-app-${count.index + 1}"
  size      = var.app_storage_gb
  server_id = hcloud_server.app[count.index].id
  automount = true
  format    = "ext4"
}

resource "hcloud_volume" "db_storage" {
  name      = "${var.name}-db"
  size      = var.db_storage_gb
  server_id = hcloud_server.db.id
  automount = true
  format    = "ext4"
}
