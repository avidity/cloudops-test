output "bucket_name"     { value = aws_s3_bucket.backups.id }
output "bucket_endpoint" { value = "https://s3.${var.region}.amazonaws.com" }
