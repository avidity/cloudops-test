terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.47"
    }
  }
}

resource "hcloud_network" "private" {
  name     = "${var.name}-net"
  ip_range = var.private_cidr
}

resource "hcloud_network_subnet" "app" {
  network_id   = hcloud_network.private.id
  type         = "cloud"
  network_zone = "eu-central"
  ip_range     = var.app_subnet_cidr
}

resource "hcloud_network_subnet" "db" {
  network_id   = hcloud_network.private.id
  type         = "cloud"
  network_zone = "eu-central"
  ip_range     = var.db_subnet_cidr
}

# app tier: allow inbound HTTP/HTTPS from world, SSH from allowed CIDRs only
resource "hcloud_firewall" "app" {
  name = "${var.name}-app-fw"

  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "22"
    source_ips = var.ssh_allowed_cidrs
    description = "SSH — ops/VPN only"
  }

  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "80"
    source_ips = ["0.0.0.0/0", "::/0"]
  }

  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "443"
    source_ips = ["0.0.0.0/0", "::/0"]
  }
}

# db tier: only reachable from app subnet on private network — no public ports
resource "hcloud_firewall" "db" {
  name = "${var.name}-db-fw"

  rule {
    direction   = "in"
    protocol    = "tcp"
    port        = "22"
    source_ips  = var.ssh_allowed_cidrs
    description = "SSH for provisioning"
  }

  rule {
    direction   = "in"
    protocol    = "tcp"
    port        = "5432"
    source_ips  = [var.app_subnet_cidr]
    description = "Postgres — app subnet only"
  }

  rule {
    direction   = "in"
    protocol    = "tcp"
    port        = "6379"
    source_ips  = [var.app_subnet_cidr]
    description = "Redis — app subnet only"
  }
}
