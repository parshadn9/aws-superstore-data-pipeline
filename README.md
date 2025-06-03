# AWS Super Store Data Engineering Project

This project demonstrates how to build a data pipeline using AWS services such as S3, Glue, Athena, and QuickSight. It processes retail sales data from the Super Store dataset to create automated snapshots, run metadata discovery, and generate insights through dashboards.

## Project Overview

- Uploads Super Store data to Amazon S3 in date-wise snapshots
- Uses AWS Glue crawler to extract metadata and store it in a Glue Data Catalog
- Queries the data using AWS Athena
- Visualizes the insights using Amazon QuickSight
- All infrastructure is managed using Terraform
- Python script automates data upload process

## Folders & Files

- `main.tf`, `provider.tf`, `variables.tf`: Terraform configuration files
- `docs/`: Contains project documentation
- `data/`: Contains source CSV data
- `scripts/`: Python scripts for automation
- `assets/`: Images of dashboard and architecture

## Technologies Used

- AWS S3
- AWS Glue
- AWS Athena
- AWS QuickSight
- Terraform
- Python (boto3)

## How to Use

1. Clone the repository
2. Configure your AWS CLI credentials
3. Run `terraform init` and `terraform apply`
4. Execute the Python script to upload daily data
5. Monitor and query using Athena and QuickSight