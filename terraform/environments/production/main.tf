# To migrate from Hetzner → AWS:
#   Change source to ../../providers/aws/* and supply subnet/sg IDs from network outputs

module "network" {
  source = "../../providers/hetzner/network"

  name              = "production"
  ssh_allowed_cidrs = var.ssh_allowed_cidrs
}

module "compute" {
  source = "../../providers/hetzner/compute"

  name               = "prod-app"
  env                = "production"
  ssh_public_key     = var.ssh_public_key
  private_network_id = module.network.private_network_id
  instance_count     = 2
  size_class         = "cx32"
  db_size_class      = "cx32"
  app_storage_gb     = 100
  db_storage_gb      = 200
}

module "storage" {
  source = "../../providers/hetzner/storage"

  bucket_name    = "mycompany-prod-backups"
  env            = "production"
  retention_days = 30
}

resource "local_file" "ansible_inventory" {
  filename        = "${path.module}/../../../ansible/inventory/production/hosts.yml"
  file_permission = "0644"
  content         = templatefile("${path.module}/inventory.tftpl", {
    app_servers   = module.compute.app_public_ips
    app_names     = module.compute.server_names
    db_private_ip = module.compute.db_private_ip
    db_name       = module.compute.db_server_name
    env           = "production"
  })
}
