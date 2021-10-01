#Define region
provider "aws" {
  region = "eu-west-2"
}
#Define ec2 instance 
resource "aws_instance" "instance1" {
  ami           = "ami-089668cd321f3cf82"
  instance_type = "t2.micro"
  tags = {
    Name = "ubuntu-20.04"
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
    Name        = "Bucket"
    Environment = "Production"
  }
  versioning {
    enabled = true
  }

}

