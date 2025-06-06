output "s3_bucket_name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.superstore_bucket.id
}

output "iam_user_name" {
  description = "IAM user created"
  value       = aws_iam_user.admin_user.name
}

output "glue_crawler_name" {
  description = "Glue crawler"
  value       = aws_glue_crawler.crawler.name
}

output "athena_output_location" {
  description = "Athena output S3 location"
  value       = "s3://${var.bucket_name}/athena_logs/"
}
