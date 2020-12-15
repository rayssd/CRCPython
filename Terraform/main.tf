terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

  backend "remote" {
    # The name of your Terraform Cloud organization.
    organization = "rayssd"

    # The name of the Terraform Cloud workspace to store Terraform state files in.
    workspaces {
      name = "CRCPython"
    }
  }
}

variable "access_key" {}
variable "secret_key" {}
variable "AWS_DEFAULT_REGION" {}

provider "aws" {
  region     = "ap-southeast-2"
  access_key = var.access_key
  secret_key = var.secret_key
}

# provider "archive" {}

# data "archive_file" "zip" {
#   type        = "zip"
#   source_file = ".\\Lambda\\dynamodb.py"
#   output_path = "lambda_payload.zip"
# }
