provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "source" {
  bucket = "bucket-virginia-bootcamp"
  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket" "destination" {
  bucket = "my-replica-bucket-california"
  provider = aws.west
  versioning {
    enabled = true
  }
}

provider "aws" {
  alias  = "west"
  region = "us-west-1"
}

resource "aws_iam_role" "replication_role" {
  name = "s3-replication-role"
  assume_role_policy = file("trust-policy.json")
}

resource "aws_iam_role_policy" "replication_policy" {
  name   = "S3ReplicationPolicy"
  role   = aws_iam_role.replication_role.id
  policy = file("replication-policy.json")
}

resource "aws_s3_bucket_replication_configuration" "replication" {
  bucket = aws_s3_bucket.source.id
  role   = aws_iam_role.replication_role.arn

  rules {
    id     = "replication-rule-for-california"
    status = "Enabled"

    destination {
      bucket        = aws_s3_bucket.destination.arn
      storage_class = "STANDARD"
    }

    filter {
      prefix = ""
    }
  }
}
