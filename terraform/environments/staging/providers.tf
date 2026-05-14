terraform {
  required_version = ">= 1.6"
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.47"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4"
    }
  }
}

provider "hcloud" {
  token = var.hcloud_token
}

provider "aws" {
  # used for S3-compatible object storage
  # for Hetzner Object Storage: set AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY
  region = "eu-central-1"
}
