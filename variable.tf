# --- AWS Region ---
variable "aws_region" {
  description = "AWS region where resources will be deployed"
  type        = string
  default     = "ap-southeast-2"
}

# --- AWS CLI Profile ---
variable "aws_profile" {
  description = "AWS CLI named profile (used locally)"
  type        = string
  default     = "default"
}

# --- S3 Bucket Name ---
variable "bucket_name" {
  description = "The globally unique name of the S3 bucket"
  type        = string
  default     = "luffy-superstore-bucket-2025"
}

# --- Glue Database Name ---
variable "glue_database_name" {
  description = "Name of the Glue catalog database"
  type        = string
  default     = "superstore_db"
}
