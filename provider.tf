provider "aws" {
  region = var.aws_region
  profile = can(var.aws_profile) && var.aws_profile != "" ? var.aws_profile : null
}