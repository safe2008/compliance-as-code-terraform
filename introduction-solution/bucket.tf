#Define region
provider "aws" {
  region = "eu-west-2"
}

#Define ec2 instance 
resource "aws_instance" "instance1" {
  ami           = "ami-089668cd321f3cf82"
  instance_type = "t2.micro"
  monitoring    = true
  ebs_optimized = true
  root_block_device {
    encrypted = true
  }
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }
  tags = {
    Name = "ubuntu-20.04"
  }
}

#Define s3 bucket
data "aws_s3_bucket" "logging" {
  bucket = "aws-audit-logging-bucket"
}

resource "aws_s3_bucket" "data" {
  bucket = "bucket-launched-using-terrafrom-20210106"
  acl    = "private" # or can be "public-read"
  tags = {
    Name        = "Bucket"
    Environment = "Production"
  }

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

