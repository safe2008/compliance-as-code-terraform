# resource "aws_s3_bucket" "data" {}

provider "aws" {
  region = "eu-west-2"
}

data "aws_s3_bucket" "logging" {
  bucket = "aws-audit-logging-bucket"
}

resource "aws_s3_bucket" "data" {
#checkov:skip=CKV_AWS_144: "Ensure that S3 bucket has cross-region replication enabled"
  bucket = "my-data-bucket"

  logging {
    target_bucket = data.aws_s3_bucket.logging.id
  }

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "aws:kms"
      }
    }
  }
}

