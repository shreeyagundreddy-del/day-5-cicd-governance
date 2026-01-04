terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
provider "aws" {
  region = var.region
}
resource "aws_s3_bucket" "data_bucket" {
    bucket = var.bucket_name
}
# Lambda template 
resource "aws_lambda_function" "example_lambda" {
  function_name = "day5-example-lambda"
  runtime       = "python3.9"
  handler       = "index.handler"

  role = "arn:aws:iam::123456789012:role/lambda-execution-role"

  filename = "lambda.zip"
  # source_code_hash intentionally omitted to avoid CI failures
}
# RDS template 
resource "aws_db_instance" "example_rds" {
  identifier        = "day5-example-rds"
  engine            = "postgres"
  instance_class    = "db.t3.micro"
  allocated_storage = 20

  username = "admin"
  password = "password123"

  skip_final_snapshot = true
}
