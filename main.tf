# --- S3 Bucket ---
resource "aws_s3_bucket" "superstore_bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = "Superstore Data Bucket v2"
    Environment = "Dev"
  }
}

# --- Athena logs folder ---
resource "aws_s3_bucket_object" "athena_logs_folder" {
  bucket = aws_s3_bucket.superstore_bucket.id
  key    = "athena_logs/"
}

# --- Glue Database ---
resource "aws_glue_catalog_database" "superstore_db" {
  name = var.glue_database_name
}

# --- IAM Role for Glue ---
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

# --- Attach Glue Policy ---
resource "aws_iam_role_policy_attachment" "glue_service_policy" {
  role       = aws_iam_role.glue_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

# --- Glue Crawler ---
resource "aws_glue_crawler" "superstore_crawler" {
  name          = "superstore-crawler-v2"
  role          = aws_iam_role.glue_service_role.arn
  database_name = aws_glue_catalog_database.superstore_db.name
  table_prefix  = "superstore_v2_"

  s3_target {
    path = "s3://${aws_s3_bucket.superstore_bucket.bucket}/orders/"
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

# --- IAM User Policy Attachment for Existing User ---
resource "aws_iam_user_policy_attachment" "admin_user_policy" {
  user       = var.iam_user_name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}