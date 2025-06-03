# Output the name of the S3 bucket
output "s3_bucket_name" {
  description = "Name of the S3 bucket created"
  value       = var.s3_bucket_name
}

# Output the Glue database name
output "glue_database_name" {
  description = "Name of the Glue database"
  value       = var.glue_database_name
}

# Output the Glue crawler name
output "glue_crawler_name" {
  description = "Name of the Glue crawler"
  value       = var.glue_crawler_name
}

# Output the IAM role name
output "glue_iam_role_name" {
  description = "Name of the IAM role used by Glue"
  value       = var.glue_role_name
}
