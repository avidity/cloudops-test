output "bucket_name"     { value = aws_s3_bucket.backups.id }
output "bucket_endpoint" { value = "https://fsn1.your-objectstorage.com" }
