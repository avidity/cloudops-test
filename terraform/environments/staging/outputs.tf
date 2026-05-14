output "app_public_ips" {
  value = module.compute.app_public_ips
}

output "db_private_ip" {
  value = module.compute.db_private_ip
}

output "bucket_name" {
  value = module.storage.bucket_name
}
