variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ap-southeast-2"
}

variable "aws_profile" {
  description = "AWS CLI profile"
  type        = string
  default     = "default"
}

variable "bucket_name" {
  description = "S3 bucket name for storing Super Store data"
  type        = string
  default     = "luffybucketonepiece"
}

variable "iam_user_name" {
  description = "IAM user name"
  type        = string
  default     = "luffyonepiece"
}

variable "glue_db_name" {
  description = "Glue catalog database name"
  type        = string
  default     = "db_luffyonepiece"
}

variable "glue_crawler_name" {
  description = "Glue crawler name"
  type        = string
  default     = "luffyhourly"
}

variable "glue_role_name" {
  description = "IAM role for Glue"
  type        = string
  default     = "AWSGlueServiceRole-luffyhour"
}
