output "private_network_id" { value = aws_vpc.this.id }
output "app_subnet_id"      { value = aws_subnet.app.id }
output "db_subnet_id"       { value = aws_subnet.db.id }
output "app_subnet_cidr"    { value = var.app_subnet_cidr }
output "db_subnet_cidr"     { value = var.db_subnet_cidr }
output "app_firewall_id"    { value = aws_security_group.app.id }
output "db_firewall_id"     { value = aws_security_group.db.id }
