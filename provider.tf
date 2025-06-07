# Configure the AWS Provider
provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile # Optional: use AWS CLI named profile
}