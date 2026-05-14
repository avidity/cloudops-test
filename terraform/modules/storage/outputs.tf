output "bucket_name" {
  value = aws_s3_bucket.backups.id
}

output "bucket_arn" {
  value = aws_s3_bucket.backups.arn
}
