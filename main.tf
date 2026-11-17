provider "aws" {
  region  = "us-east-2"
  profile = "devsecops-tf"

  default_tags {
    tags = {
      Environment = "Dev"
      Project     = "aws-devsecops-project"
    }
  }
}

resource "aws_s3_bucket" "tfstate" {
  bucket = "ankush-devsecops-tfstate-111"

  tags = {
    Name = "Ankush_bucket"
  }
  lifecycle {
    prevent_destroy = true
  }

}

resource "aws_s3_bucket_public_access_block" "tfstate" {
  bucket                  = aws_s3_bucket.tfstate.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_kms_key" "tfstate" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
  enable_key_rotation     = true
  lifecycle {
    prevent_destroy = true
  }
}


resource "aws_s3_bucket_server_side_encryption_configuration" "tfstate" {
  bucket = aws_s3_bucket.tfstate.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.tfstate.arn
      sse_algorithm     = "aws:kms"
    }
    bucket_key_enabled = true
  }
}



resource "aws_s3_bucket_versioning" "tfstate" {
  bucket = aws_s3_bucket.tfstate.id
  versioning_configuration {
    status = "Enabled"
  }
}



##### for organization


moved {
  from = aws_s3_bucket.Ankush_bucket
  to   = aws_s3_bucket.tfstate
}

moved {
  from = aws_s3_bucket_public_access_block.Ankush_bucket
  to   = aws_s3_bucket_public_access_block.tfstate
}

moved {
  from = aws_s3_bucket_versioning.Ankush_bucket
  to   = aws_s3_bucket_versioning.tfstate
}

moved {
  from = aws_s3_bucket_server_side_encryption_configuration.Ankush_bucket
  to   = aws_s3_bucket_server_side_encryption_configuration.tfstate
}

moved {
  from = aws_kms_key.mykey
  to   = aws_kms_key.tfstate
}