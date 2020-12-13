terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

variable "access_key" {}
variable "secret_key" {}

provider "aws" {
  region     = "ap-southeast-2"
  access_key = var.access_key
  secret_key = var.secret_key
}

provider "archive" {}

data "archive_file" "zip" {
  type        = "zip"
  source_file = "C:\\Users\\Loki\\OneDrive\\Cloud Resume Challenge\\Lambda\\dynamodb.py"
  output_path = "lambda_payload.zip"
}
