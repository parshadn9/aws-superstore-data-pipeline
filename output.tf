# Output the name of the S3 bucket
output "s3_bucket_name" {
  description = "The name of the S3 bucket used for Superstore data storage"
  value       = aws_s3_bucket.superstore_bucket.bucket
}

# Output the name of the AWS Glue catalog database
output "glue_catalog_database_name" {
  description = "The name of the Glue catalog database"
  value       = aws_glue_catalog_database.superstore_db.name
}

# Output the name of the IAM role used by AWS Glue
output "glue_iam_role_name" {
  description = "The name of the IAM role assigned to AWS Glue"
  value       = aws_iam_role.glue_service_role.name
}
