# --- S3 Bucket for Superstore Data and Athena Logs ---
resource "aws_s3_bucket" "superstore_bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = "Superstore Data Bucket"
    Environment = "Dev"
  }
}

# Create Athena logs folder as an empty object (recommended method)
resource "aws_s3_object" "athena_logs_folder" {
  bucket  = aws_s3_bucket.superstore_bucket.id
  key     = "athena_logs/"
  content = ""
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
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "glue.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Attach Glue Managed Policy to Glue Role
resource "aws_iam_role_policy_attachment" "glue_policy_attachment" {
  role       = aws_iam_role.glue_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

# --- Attach Admin Policy to Existing IAM User ---
resource "aws_iam_user_policy_attachment" "luffyonepiece_admin" {
  user       = var.iam_user_name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
