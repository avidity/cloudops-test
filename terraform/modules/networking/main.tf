resource "hcloud_firewall" "this" {
  name = "${var.name}-fw"

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "22"
    source_ips = var.ssh_allowed_cidrs
    description = "SSH"
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

resource "hcloud_firewall_attachment" "this" {
  firewall_id = hcloud_firewall.this.id
  server_ids  = var.server_ids
}

resource "hcloud_rdns" "this" {
  count      = length(var.server_ips)
  server_id  = var.server_ids[count.index]
  ip_address = var.server_ips[count.index]
  dns_ptr    = count.index == 0 ? var.domain : "${count.index}.${var.domain}"
}
