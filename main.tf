

# --- S3 Bucket for Data Storage ---
resource "aws_s3_bucket" "superstore_bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = "Superstore Data Bucket"
    Environment = "Dev"
  }
}

# --- S3 Object for Athena logs (folder simulation) ---
resource "aws_s3_bucket_object" "athena_logs_folder" {
  bucket = aws_s3_bucket.superstore_bucket.id
  key    = "athena_logs/"  # This simulates a folder inside the bucket
}

# --- Glue Catalog Database ---
resource "aws_glue_catalog_database" "superstore_db" {
  name = var.glue_database_name
}

# --- IAM Role for AWS Glue ---
resource "aws_iam_role" "glue_service_role" {
  name = var.glue_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "glue.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

# --- Attach Glue Service Policy to IAM Role ---
resource "aws_iam_role_policy_attachment" "glue_service_policy" {
  role       = aws_iam_role.glue_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

# --- Glue Crawler to scan S3 data ---
resource "aws_glue_crawler" "superstore_crawler" {
  name          = "superstore-crawler"
  role          = aws_iam_role.glue_service_role.arn
  database_name = aws_glue_catalog_database.superstore_db.name
  table_prefix  = "superstore_"

  s3_target {
    path = "s3://${var.bucket_name}/raw/"
  }

  configuration = jsonencode({
    Version = 1.0,
    CrawlerOutput = {
      Partitions = {
        AddOrUpdateBehavior = "InheritFromTable"
      }
    }
  })

  depends_on = [
    aws_glue_catalog_database.superstore_db,
    aws_s3_bucket.superstore_bucket
  ]
}

# --- IAM User Resource (Optional, if needed) ---
resource "aws_iam_user" "admin_user" {
  name = var.iam_user_name
}

# --- IAM Policy Attachment to IAM User ---
resource "aws_iam_user_policy_attachment" "admin_user_policy" {
  user       = aws_iam_user.admin_user.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}