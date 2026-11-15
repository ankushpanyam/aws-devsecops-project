provider "aws" {
  region  = "us-east-2"
  profile = "devsecops-tf"
}

resource "aws_s3_bucket" "Ankush_bucket" {
  bucket = "ankush-devsecops-tfstate-111"

  tags = {
    Name        = "Ankush_bucket"
    Environment = "Dev"
    Project     = "aws-devsecops-project"
  }

  lifecycle {
    prevent_destroy = true
  }
}



resource "aws_s3_bucket_public_access_block" "Ankush_bucket" {
  bucket                  = aws_s3_bucket.Ankush_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_kms_key" "mykey" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
  enable_key_rotation     = true
}


resource "aws_s3_bucket_server_side_encryption_configuration" "Ankush_bucket" {
  bucket = aws_s3_bucket.Ankush_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.mykey.arn
      sse_algorithm     = "aws:kms"
    }
    bucket_key_enabled = true
  }
}



resource "aws_s3_bucket_versioning" "Ankush_bucket" {
  bucket = aws_s3_bucket.Ankush_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}