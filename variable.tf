# --- AWS Region ---
variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "ap-southeast-2"
}

# --- AWS CLI Profile ---
variable "aws_profile" {
  description = "AWS CLI named profile"
  type        = string
  default     = "default"
}

# --- S3 Bucket Name ---
variable "bucket_name" {
  description = "The name of the S3 bucket to be created"
  type        = string
}

# --- Glue Database Name ---
variable "glue_database_name" {
  description = "Name of the AWS Glue catalog database"
  type        = string
}
