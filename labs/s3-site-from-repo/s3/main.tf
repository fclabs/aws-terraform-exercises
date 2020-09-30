
## Search Lambda Role
data "aws_iam_role" "lambda_role" {
    name = var.lambda_role_name
}

## Creaste a list of files to upload
locals {
    bucket_policy = <<EOP
{
    "Version": "2012-10-17",
    "Id": "PublicAccess",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::${local.bucket_name}/*"
            ]
        },
        {
            "Sid": "LambdaFuncAccess",
            "Effect": "Allow",
            "Principal": {
                "AWS" : "${data.aws_iam_role.lambda_role.arn}" 
            },
            "Action": [
                "s3:PutObject"
            ],
            "Resource": [
                "arn:aws:s3:::${local.bucket_name}/*"
            ]
        }
    ]
}
EOP

    lambda_function_s3_policy = <<EOP
{
    "Version": "2012-10-17",
    "Id": "S3Access",
    "Statement": [
        {
            "Sid": "PutObjectOnS3",
            "Effect": "Allow",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::${local.bucket_name}/*"
            ]
        }
    ]
}
EOP
}

### Create S3 buckets
module "s3_site" {
    source = "../../modules/s3"
    bucket = local.bucket_name
    bucket_policy = [local.bucket_policy]

    bucket_public = true

    website = [
        {
            index_document = "index.html"
            error_document = "error.html"
            routing_rules = ""
        }
    ]
}

## Creates and attach another policy to the Lambda Role, now that the bucket is created.
resource "aws_iam_policy" "lambda_function_s3_policy" {
    name        = "${var.lambda_role_name}-Lambda-S3-Policy"
    policy = local.lambda_function_s3_policy
}
resource "aws_iam_role_policy_attachment" "test-attach" {
    role = var.lambda_role_name
    policy_arn = aws_iam_policy.lambda_function_s3_policy.arn
}


# Register the bucket FQDN as www record on DNS zone 
# module "dns_record_media" {
#     source = "../../modules/route53"

#     zone = var.dns_zone
#     records = [
#         {
#             name = "www"
#             ttl = 60
#             type = "CNAME"
#             values = [ module.s3_site.bucket_website_endpoint ]           
#         }
#     ]
# }  

