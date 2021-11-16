#Define region
provider "aws" {
  region = "eu-west-2"
}
#Define ec2 instance 
resource "aws_instance" "instance1" {
  ami           = "ami-089668cd321f3cf82"
  instance_type = "t2.micro"
  tags = {
    Name                 = "ubuntu-20.04"
    git_commit           = "6d21bd4b6f46cdcf6b6e0ac04af6c7ff1ecb5d07"
    git_file             = "introduction/resource.tf"
    git_last_modified_at = "2021-10-01 05:03:13"
    git_last_modified_by = "boriphuth.sa@gmail.com"
    git_modifiers        = "boriphuth.sae"
    git_org              = "safe2008"
    git_repo             = "compliance-as-code-terraform"
    yor_trace            = "df692152-4f79-4138-82ba-34f771b9ad3e"
  }
}
#Define s3 bucket
data "aws_s3_bucket" "logging" {
  bucket = "aws-audit-logging-bucket"
}

resource "aws_s3_bucket" "data" {
  bucket = "bucket-launched-using-terrafrom-20211006"
  acl    = "private" # or can be "public-read"
  tags = {
    Name                 = "Bucket"
    Environment          = "Production"
    git_commit           = "6d21bd4b6f46cdcf6b6e0ac04af6c7ff1ecb5d07"
    git_file             = "introduction/resource.tf"
    git_last_modified_at = "2021-10-01 05:03:13"
    git_last_modified_by = "boriphuth.sa@gmail.com"
    git_modifiers        = "boriphuth.sae"
    git_org              = "safe2008"
    git_repo             = "compliance-as-code-terraform"
    yor_trace            = "817fad02-f398-4c8b-9fd6-7ae4338ed263"
  }
  versioning {
    enabled = true
  }

}

