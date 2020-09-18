
### Search resources
## S3 Media bucket
data "aws_s3_bucket" "s3media" {
    bucket = var.bucket_name_media
}

### Create CloufFront distribution
module "cloudfront-media" {
   source = "../../modules/cloudfront"

   target_origin_id = var.cf_target_origin_id 
   origin_domain_name = data.aws_s3_bucket.s3media.bucket_domain_name
}

locals {
    s3_media_bucket_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": {
                "AWS" : "${module.cloudfront-media.oai_arn}"
                },
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "${data.aws_s3_bucket.s3media.arn}/*"
            ]
        }
    ]
}
POLICY
}

module "s3_media_pol" {
    source = "../../modules/s3"
    
    s3_create = false
    bucket = var.bucket_name_media

    bucket_policy = [local.s3_media_bucket_policy]
}


# Register the cloudfront FQDN as media record on DNS zone 
module "dns_record_media" {
    source = "../../modules/route53"

    zone = var.dns_zone
    records = [
        {
            name = "media"
            ttl = 60
            type = "CNAME"
            values = [ module.cloudfront-media.domain_name ]           
        }
    ]
}         