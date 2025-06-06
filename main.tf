# IAM user
resource "aws_iam_user" "admin_user" {
  name = var.iam_user_name
}

resource "aws_iam_user_policy_attachment" "admin_access" {
  user       = aws_iam_user.admin_user.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# S3 bucket and folders
resource "aws_s3_bucket" "superstore_bucket" {
  bucket = var.bucket_name
  tags = {
    Name = "Superstore Data Bucket"
  }
}

resource "aws_s3_bucket_object" "athena_logs" {
  bucket = aws_s3_bucket.superstore_bucket.id
  key    = "athena_logs/"
}

# IAM role for Glue
resource "aws_iam_role" "glue_role" {
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

resource "aws_iam_role_policy_attachment" "glue_s3_access" {
  role       = aws_iam_role.glue_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "glue_service" {
  role       = aws_iam_role.glue_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

# Glue catalog database
resource "aws_glue_catalog_database" "catalog_db" {
  name = var.glue_db_name
}

# Glue crawler
resource "aws_glue_crawler" "crawler" {
  name          = var.glue_crawler_name
  role          = aws_iam_role.glue_role.arn
  database_name = aws_glue_catalog_database.catalog_db.name
  schedule      = "cron(0 * * * ? *)"

  s3_target {
    path = "s3://${var.bucket_name}/orders/"
  }

  configuration = jsonencode({
    Version = 1.0,
    CrawlerOutput = {
      UpdateBehavior = "UPDATE_IN_DATABASE"
    }
  })
}

# Athena workgroup
resource "aws_athena_workgroup" "primary" {
  name = "primary"
  configuration {
    result_configuration {
      output_location = "s3://${var.bucket_name}/athena_logs/"
    }
  }
}
