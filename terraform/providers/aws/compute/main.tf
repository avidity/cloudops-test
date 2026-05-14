terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

data "aws_ami" "debian" {
  most_recent = true
  owners      = ["136693071363"]  # Debian official account
  filter {
    name   = "name"
    values = ["debian-12-amd64-*"]
  }
}

resource "aws_key_pair" "deploy" {
  key_name   = "${var.name}-deploy"
  public_key = var.ssh_public_key
}

resource "aws_instance" "app" {
  count                       = var.instance_count
  ami                         = data.aws_ami.debian.id
  instance_type               = var.size_class
  key_name                    = aws_key_pair.deploy.key_name
  subnet_id                   = var.app_subnet_id
  vpc_security_group_ids      = [var.app_security_group_id]
  associate_public_ip_address = true
  user_data                   = file("${path.module}/cloud-init.yml")

  root_block_device {
    volume_size = var.app_storage_gb
    volume_type = "gp3"
    encrypted   = true
  }

  tags = { Name = "${var.name}-app-${count.index + 1}", env = var.env, role = "app" }

  lifecycle {
    prevent_destroy = var.prevent_destroy
    ignore_changes  = [user_data, ami]
  }
}

resource "aws_instance" "db" {
  ami                         = data.aws_ami.debian.id
  instance_type               = var.db_size_class
  key_name                    = aws_key_pair.deploy.key_name
  subnet_id                   = var.db_subnet_id
  vpc_security_group_ids      = [var.db_security_group_id]
  associate_public_ip_address = false  # db has no public IP
  user_data                   = file("${path.module}/cloud-init.yml")

  root_block_device {
    volume_size = var.db_storage_gb
    volume_type = "gp3"
    encrypted   = true
  }

  tags = { Name = "${var.name}-db", env = var.env, role = "db" }

  lifecycle {
    prevent_destroy = var.prevent_destroy
  }
}
