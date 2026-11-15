terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.92"
    }


  }

  required_version = ">= 1.10"


 backend "s3" {
    bucket = "ankush-devsecops-tfstate-111"
    key    = "aws-devsecops-project/terraform.tfstate"
    region = "us-east-2"
    profile = "devsecops-tf"
    encrypt      = true
    use_lockfile = true
  }


}


