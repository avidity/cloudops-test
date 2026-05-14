output "private_network_id" { value = hcloud_network.private.id }
output "app_subnet_cidr"    { value = var.app_subnet_cidr }
output "db_subnet_cidr"     { value = var.db_subnet_cidr }
output "app_firewall_id"    { value = hcloud_firewall.app.id }
output "db_firewall_id"     { value = hcloud_firewall.db.id }
