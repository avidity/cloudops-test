output "app_public_ips"  { value = aws_instance.app[*].public_ip }
output "app_private_ips" { value = aws_instance.app[*].private_ip }
output "db_private_ip"   { value = aws_instance.db.private_ip }
output "server_names"    { value = aws_instance.app[*].tags.Name }
output "db_server_name"  { value = aws_instance.db.tags.Name }
