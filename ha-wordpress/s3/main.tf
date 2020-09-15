### Create S3 buckets
module "s3_media" {
    source = "../../modules/s3"
    bucket = var.bucket_name_media
}

module "s3_code" {
    source = "../../modules/s3"
    bucket = var.bucket_name_code
}

### Create IAM Policy to manage the S3 buckets fron the instances
locals {
    s3_instance_policy = <<EOT
{
    "Version": "2012-10-17",
    "Statement": 
    [
        {
            "Sid": "ObjectActions",
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:PutObjectAcl",
                "s3:GetObject",
                "s3:GetObjectAcl",
                "s3:DeleteObject"
            ],
            "Resource": [ "${module.s3_media.arn}/*" , "${module.s3_code.arn}/*" ]
        },
        {
            "Sid": "ListObjectBucket",
            "Effect": "Allow",
            "Action": "s3:ListBucket",
            "Resource": [ "${module.s3_media.arn}" , "${module.s3_code.arn}" ]
        }
    ]
}
EOT
}

module "iam_ec2_prof" {
    source = "../../modules/iam"

    instance_profiles = [
        {
            name = var.iam_instance_profile_name
            
            policy = local.s3_instance_policy
        }
    ]
}