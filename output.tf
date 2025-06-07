output "s3_bucket_name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.superstore_bucket.bucket
}

output "glue_catalog_database_name" {
  description = "The Glue catalog database name"
  value       = aws_glue_catalog_database.superstore_db.name
}

output "glue_iam_role_name" {
  description = "The IAM role used by AWS Glue"
  value       = aws_iam_role.glue_service_role.name
}
