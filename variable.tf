variable "aws_region" {
  description = "The AWS region where resources will be deployed"
  type        = string
  default     = "ap-southeast-2"
}

variable "bucket_name" {
  description = "The name of the S3 bucket to create or manage"
  type        = string
  default     = "luffy-superstore-bucket-2025-v2"
}

variable "glue_database_name" {
  description = "The name of the Glue catalog database"
  type        = string
  default     = "superstore_db_v2"
}

variable "glue_role_name" {
  description = "The name of the IAM role for AWS Glue"
  type        = string
  default     = "AWSGlueServiceRole-luffyhour-v2"
}

variable "iam_user_name" {
  description = "The name of the existing IAM user to attach policies to"
  type        = string
  default     = "luffyonepiece"
}
