# AWS Region to deploy resources
variable "aws_region" {
  description = "The AWS region where resources will be deployed"
  type        = string
  default     = "ap-southeast-2"
}

# S3 Bucket Name for storing Superstore data and Athena logs
variable "bucket_name" {
  description = "The name of the S3 bucket to create or manage"
  type        = string
  default     = "luffy-superstore-bucket-2025"
}

# Glue Catalog Database Name
variable "glue_database_name" {
  description = "The name of the Glue catalog database"
  type        = string
  default     = "superstore_db"
}

# Glue IAM Role Name
variable "glue_role_name" {
  description = "The name of the IAM role for AWS Glue"
  type        = string
  default     = "AWSGlueServiceRole-luffyhour"
}

# Existing IAM User Name (used for attaching policies only)
variable "iam_user_name" {
  description = "The name of the existing IAM user to attach policies to"
  type        = string
  default     = "luffyonepiece"
}
