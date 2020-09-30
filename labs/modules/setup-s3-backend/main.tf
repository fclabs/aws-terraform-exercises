
locals {
    s3_bucket_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "TerraformObjectAccess",
            "Effect": "Allow",
            "Principal": { "AWS" : "${var.terraform_arn}" },
            "Action": [
                "s3:GetObject" ,
                "s3:PutObject"
            ],
            "Resource": [
                "arn:aws:s3:::${var.name}/*"
            ]
        },
        {
            "Sid": "TerraformBucketAccess",
            "Effect": "Allow",
            "Principal": { "AWS" : "${var.terraform_arn}" },
            "Action": [
                "s3:ListBucket" 
            ],
            "Resource": [
                "arn:aws:s3:::${var.name}"
            ]
        }
    ]
}
POLICY
}

resource "aws_s3_bucket" "terraform_state" {
    bucket = var.name
    # Enable versioning so we can see the full revision history of our
    # state files
    versioning {
        enabled = true
    }

    policy = local.s3_bucket_policy
    
    # Enable server-side encryption by default
    server_side_encryption_configuration {
        rule {
            apply_server_side_encryption_by_default {
                sse_algorithm = "AES256"
            }
        }
    }
}

resource "aws_dynamodb_table" "terraform_locks" {
    name         = var.name
    billing_mode = "PAY_PER_REQUEST"
    hash_key     = "LockID"
    attribute {
        name = "LockID"
        type = "S"
    }
}

