# Hetzner Object Storage is S3-compatible — same terraform resource works
# for AWS S3 too, just swap provider + endpoint

resource "aws_s3_bucket" "backups" {
  bucket = var.bucket_name

  tags = {
    env = var.env
  }
}

resource "aws_s3_bucket_versioning" "backups" {
  bucket = aws_s3_bucket.backups.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "backups" {
  bucket = aws_s3_bucket.backups.id

  rule {
    id     = "expire-old-backups"
    status = "Enabled"

    expiration {
      days = var.retention_days
    }
  }
}

# block all public access — backups should never be public
resource "aws_s3_bucket_public_access_block" "backups" {
  bucket                  = aws_s3_bucket.backups.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
