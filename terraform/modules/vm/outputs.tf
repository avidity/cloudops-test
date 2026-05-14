output "server_ips" {
  value = hcloud_server.this[*].ipv4_address
}

output "server_names" {
  value = hcloud_server.this[*].name
}

output "server_ids" {
  value = hcloud_server.this[*].id
}
