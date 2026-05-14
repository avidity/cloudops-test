# To migrate from Hetzner → AWS:
#   1. Change source paths below to ../../providers/aws/*
#   2. Add aws-specific variables (subnet_id, security_group_id from network outputs)
#   3. Run terraform init && terraform plan

module "network" {
  source = "../../providers/hetzner/network"

  name             = "staging"
  ssh_allowed_cidrs = ["0.0.0.0/0", "::/0"]  # TODO: lock to VPN in prod
}

module "compute" {
  source = "../../providers/hetzner/compute"

  name               = "staging-app"
  env                = "staging"
  ssh_public_key     = var.ssh_public_key
  private_network_id = module.network.private_network_id
  instance_count     = 1
  size_class         = "cx22"
  db_size_class      = "cx22"
  app_storage_gb     = 40
  db_storage_gb      = 60
}

module "storage" {
  source = "../../providers/hetzner/storage"

  bucket_name    = "mycompany-staging-backups"
  env            = "staging"
  retention_days = 14
}

resource "local_file" "ansible_inventory" {
  filename        = "${path.module}/../../../ansible/inventory/staging/hosts.yml"
  file_permission = "0644"
  content         = templatefile("${path.module}/inventory.tftpl", {
    app_servers    = module.compute.app_public_ips
    app_names      = module.compute.server_names
    db_private_ip  = module.compute.db_private_ip
    db_name        = module.compute.db_server_name
    env            = "staging"
  })
}
