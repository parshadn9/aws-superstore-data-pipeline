# --- S3 Bucket for Superstore Data and Athena Logs ---
resource "aws_s3_bucket" "superstore_bucket" {
  bucket = "luffy-superstore-bucket-2025"

  tags = {
    Name        = "Superstore Data Bucket"
    Environment = "Dev"
  }
}

# Create Athena log folder in the bucket
resource "aws_s3_bucket_object" "athena_logs_folder" {
  bucket = aws_s3_bucket.superstore_bucket.id
  key    = "athena_logs/"  # Creates folder-like path
}

# --- Glue Catalog Database ---
resource "aws_glue_catalog_database" "superstore_db" {
  name = "superstore_db"
}

# --- IAM Role for AWS Glue ---
resource "aws_iam_role" "glue_service_role" {
  name = "AWSGlueServiceRole-luffyhour"

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

# --- IAM Policy Attachment for Existing User (luffyonepiece) ---
resource "aws_iam_user_policy_attachment" "luffyonepiece_admin" {
  user       = "luffyonepiece"
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
