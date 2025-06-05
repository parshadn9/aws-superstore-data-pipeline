# --- S3 Bucket for Storing Data and Athena Logs ---
resource "aws_s3_bucket" "luffybucketonepiece" {
  bucket = var.bucket_name

  tags = {
    Name        = "Superstore Data Bucket"
    Environment = "Dev"
  }
}

# Create an 'athena_logs/' folder in the S3 bucket
resource "aws_s3_bucket_object" "athena_output_folder" {
  bucket = aws_s3_bucket.superstore_bucket.id
  key    = "athena_logs/"  # Creates a folder-like path
}

# --- IAM Role for Glue ---
resource "aws_iam_role" "glue_service_role" {
  name = "AWSGlueServiceRole-luffyhour"

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

# Attach Glue Service Policy
resource "aws_iam_role_policy_attachment" "glue_policy_attach" {
  role       = aws_iam_role.glue_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

resource "aws_glue_crawler" "superstore_crawler" {
  name          = "luffyhourly"
  role          = aws_iam_role.glue_service_role.arn
  database_name = var.database_name
  schedule      = "cron(0 * * * ? *)"  # Runs every hour

  s3_target {
    path = "s3://${aws_s3_bucket.superstore_bucket.bucket}/orders/"
  }

  configuration = jsonencode({
    Version = 1.0,
    CrawlerOutput = {
      Partitions = {
        AddOrUpdateBehavior = "InheritFromTable"
      }
    },
    Grouping = {
      TableGroupingPolicy = "CombineCompatibleSchemas"
    }
  })
}

# --- Athena Database ---
resource "aws_athena_database" "superstore_athena_db" {
  name   = var.athena_database_name
  bucket = aws_s3_bucket.superstore_bucket.id
}

# --- Athena Workgroup ---
resource "aws_athena_workgroup" "superstore_workgroup" {
  name = "luffy-workgroup"

  configuration {
    result_configuration {
      output_location = "s3://${aws_s3_bucket.superstore_bucket.bucket}/athena_logs/"
    }
  }

  force_destroy = true
  state         = "ENABLED"
}
