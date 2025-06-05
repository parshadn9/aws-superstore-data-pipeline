resource "aws_s3_bucket" "data" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_object" "orders_prefix" {
  bucket = aws_s3_bucket.data.id
  key    = "orders/"
}

resource "aws_glue_catalog_database" "glue_db" {
  name = "db_luffy_pipeline"  # Updated name to avoid AlreadyExistsException
}

resource "aws_iam_role" "glue_role" {
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

resource "aws_iam_role_policy_attachment" "glue_service_policy" {
  role       = aws_iam_role.glue_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

resource "aws_iam_role_policy_attachment" "s3_read_policy" {
  role       = aws_iam_role.glue_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

resource "aws_glue_crawler" "crawler" {
  name          = "luffyhourly"
  role          = aws_iam_role.glue_role.arn
  database_name = aws_glue_catalog_database.glue_db.name
  schedule      = "cron(0 * * * ? *)"  # Every hour

  s3_target {
    path = "s3://${aws_s3_bucket.data.bucket}/orders/"
  }

  depends_on = [
    aws_s3_bucket_object.orders_prefix
  ]
}
# Athena Workgroup (optional but helpful for logging)
resource "aws_athena_workgroup" "luffy_workgroup" {
  name = "luffy_analytics"

  configuration {
    result_configuration {
      output_location = "s3://${aws_s3_bucket.data.bucket}/athena_logs/"
    }
  }
