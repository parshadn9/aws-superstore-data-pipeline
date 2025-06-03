# AWS Region
variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "ap-southeast-2"  # Sydney
}

# AWS CLI Profile Name (optional, used if not default)
variable "aws_profile" {
  description = "AWS CLI named profile to use for authentication"
  type        = string
  default     = "default"
}

# S3 Bucket Name
variable "s3_bucket_name" {
  description = "The name of the S3 bucket to store Superstore data"
  type        = string
  default     = "luffybucketonepiece"
}

# Glue Database Name
variable "glue_database_name" {
  description = "Name of the AWS Glue database"
  type        = string
  default     = "db_luffyonepiece"
}

# Glue Crawler Name
variable "glue_crawler_name" {
  description = "Name of the AWS Glue crawler"
  type        = string
  default     = "luffyhourly"
}

# Glue IAM Role Name
variable "glue_role_name" {
  description = "IAM role name used by Glue crawler"
  type        = string
  default     = "AWSGlueServiceRole-luffyhour"
}
