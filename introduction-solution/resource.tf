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
    Name                 = "ubuntu-20.04"
    git_commit           = "6d21bd4b6f46cdcf6b6e0ac04af6c7ff1ecb5d07"
    git_file             = "introduction-solution/resource.tf"
    git_last_modified_at = "2021-10-01 05:03:13"
    git_last_modified_by = "boriphuth.sa@gmail.com"
    git_modifiers        = "boriphuth.sae"
    git_org              = "safe2008"
    git_repo             = "compliance-as-code-terraform"
    yor_trace            = "c8bd17d7-43f0-4375-af6b-62086a1bcbfc"
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
    Name                 = "Bucket"
    Environment          = "Production"
    git_commit           = "6d21bd4b6f46cdcf6b6e0ac04af6c7ff1ecb5d07"
    git_file             = "introduction-solution/resource.tf"
    git_last_modified_at = "2021-10-01 05:03:13"
    git_last_modified_by = "boriphuth.sa@gmail.com"
    git_modifiers        = "boriphuth.sae"
    git_org              = "safe2008"
    git_repo             = "compliance-as-code-terraform"
    yor_trace            = "4c6a3fb9-4885-4162-a749-a0899c2173a1"
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

