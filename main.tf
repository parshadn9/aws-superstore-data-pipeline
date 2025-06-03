# Create an S3 bucket for storing Super Store data
resource "aws_s3_bucket" "superstore_data" {
  bucket = "luffybucketonepiece"

  tags = {
    Name        = "Luffy Superstore Data"
    Environment = "Dev"
    Project     = "Superstore Data Pipeline"
  }
}

# Glue Database
resource "aws_glue_catalog_database" "luffy_db" {
  name = "db_luffyonepiece"
}

# IAM Role for Glue Crawler
resource "aws_iam_role" "glue_crawler_role" {
  name = "AWSGlueServiceRole-luffyhour"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Principal = {
        Service = "glue.amazonaws.com"
      }
      Effect = "Allow"
      Sid    = ""
    }]
  })
}

# Attach policies to IAM role
resource "aws_iam_role_policy_attachment" "glue_policy" {
  role       = aws_iam_role.glue_crawler_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

# Glue Crawler to scan S3
resource "aws_glue_crawler" "luffy_crawler" {
  name          = "luffyhourly"
  role          = aws_iam_role.glue_crawler_role.arn
  database_name = aws_glue_catalog_database.luffy_db.name
  schedule      = "cron(0 * * * ? *)"  # Every hour

  s3_target {
    path = "s3://${aws_s3_bucket.superstore_data.bucket}/orders/"
  }
}