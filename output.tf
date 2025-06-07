output "bucket_name" {
  value = aws_s3_bucket.superstore_bucket.bucket
}

output "glue_database_name" {
  value = aws_glue_catalog_database.superstore_db.name
}

output "glue_service_role" {
  value = aws_iam_role.glue_service_role.name
}
