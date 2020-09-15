
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

           