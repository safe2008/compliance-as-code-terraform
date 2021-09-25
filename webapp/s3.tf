resource "aws_s3_bucket" "static_content" {
  # checkov:skip=CKV_AWS_20:The bucket is a public static content host
  bucket = "static.webapp.com"
  acl    = "public-read"
  force_destroy = true
  website {
    index_document = "index.html"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  versioning {
    enabled = true
    mfa_delete = true
  }
  logging {
    target_bucket = aws_s3_bucket.static_content.id
    target_prefix = "log/"
  }
}
