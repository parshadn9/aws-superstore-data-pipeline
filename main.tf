

# --- S3 Bucket for Storing Data and Athena Logs ---
resource "aws_s3_bucket" "superstore_bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = "Superstore Data Bucket"
    Environment = "Dev"
  }
}

# --- Athena Logs Folder ---
resource "aws_s3_object" "athena_logs" {
  bucket  = aws_s3_bucket.superstore_bucket.bucket
  key     = "athena_logs/"
  content = "" # Required to create an empty object
}

# --- Use Existing IAM User (Import Before Applying) ---
resource "aws_iam_user" "admin_user" {
  name = "onepieceluffy"
}

# --- Attach Admin Policy to Existing User ---
resource "aws_iam_user_policy_attachment" "admin_access" {
  user       = aws_iam_user.admin_user.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# --- Glue Catalog Database ---
resource "aws_glue_catalog_database" "superstore_db" {
  name = var.glue_database_name
}

# --- IAM Role for Glue Service ---
resource "aws_iam_role" "glue_service_role" {
  name = "AWSGlueServiceRole-luffyhourzoro"

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

# --- Attach Glue Service Policy ---
resource "aws_iam_role_policy_attachment" "glue_service_policy" {
  role       = aws_iam_role.glue_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

# --- AWS Glue Crawler ---
resource "aws_glue_crawler" "crawler" {
  name          = "luffyhourly"
  role          = aws_iam_role.glue_service_role.arn
  database_name = aws_glue_catalog_database.superstore_db.name

  s3_target {
    path = "s3://${aws_s3_bucket.superstore_bucket.bucket}/data/"
  }

  schedule = "cron(0 * * * ? *)"
}

# --- Athena WorkGroup (Custom) ---
resource "aws_athena_workgroup" "custom_wg" {
  name = "luffy_workgroup"

  configuration {
    result_configuration {
      output_location = "s3://${aws_s3_bucket.superstore_bucket.bucket}/athena_logs/"
    }
  }

  state = "ENABLED"
}
