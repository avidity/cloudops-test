output "app_public_ips"  { value = hcloud_server.app[*].ipv4_address }
output "app_private_ips" { value = [for s in hcloud_server.app : tolist(s.network)[0].ip] }
output "db_private_ip"   { value = tolist(hcloud_server.db.network)[0].ip }
output "server_names"    { value = hcloud_server.app[*].name }
output "db_server_name"  { value = hcloud_server.db.name }
