#
# Bucket where we will store user details
#
resource "aws_s3_bucket" "personal_data" {
  bucket = "user-personal-data"
  acl    = "read-write"
  force_destroy = true
  tags = {
    Name        = "user-personal-data-store"
    Environment = "production"
    Owner       = "AwesomeSquad"
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
    target_bucket = aws_s3_bucket.personal_data.id
    target_prefix = "log/"
  }
}

#
# EC2 instance to process user details for marketing research
#
resource "aws_instance" "data_processor" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  
  # Permissions for EC2 instance to access the S3 bucket
  iam_instance_profile = aws_iam_instance_profile.data_processor.id
  
  root_block_device {
    # 10 GiB volume size
    volume_size = 10
    encrypted = true
  }

  tags = {
    Name        = "user-personal-data-processor"
    Environment = "production"
    Owner       = "AwesomeSquad"
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }
}

#
# EC2 IAM role config
#
resource "aws_iam_instance_profile" "data_processor" {
  name = "data-processor-profile"
  role = aws_iam_role.data_processor.name
}

resource "aws_iam_role" "data_processor" {
  name = "data-processor-role"
  path = "/"

  assume_role_policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  }
  EOF
}

resource "aws_iam_role_policy" "test_policy" {
  name   = "data-processor-role"
  role       = aws_iam_role.data_processor.name
  policy = data.aws_iam_policy_document.data_processor.json
}

#
# The EC2 role policy: 
#
data "aws_iam_policy_document" "data_processor" {
  
  # Entity can list the files in the bucket
  statement {
    sid = "AllowListBucketContents"
    actions = [
      "s3:ListBucket",
    ]

    resources = aws_s3_bucket.personal_data.arn
  }
    
  # Entity can read all files in the bucket and their config:
  # GetObjectAcl, GetObjectTagging, and so on. Simplified with wildcard
  statement {
    sid = "AllowAllObjectReads"
    
    # Allows all object read-only actions, s3:GetObject*
    actions = [
      "s3:GetObject*"
    ]

    resources = [
      "${aws_s3_bucket.personal_data.arn}/*"
    ]
  }
  
  # Entity can write new files to the bucket and set permissions and retention
  # No wildcard, to explicitly limit the allowed actions.
  statement {
    sid = "AllowLimitedObjectWrites"
    
    actions = [
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:PutObjectRetention",
    ]

    resources = [
      "${aws_s3_bucket.personal_data.arn}/*"
    ]
  }
}