

### Create S3 buckets
module "s3_media" {
    source = "./modules/s3"
    bucket = var.bucket_name_media
}

module "s3_code" {
    source = "./modules/s3"
    bucket = var.bucket_name_code
}

### Create CloufFront distribution
#module "cloudfront-media" {
#    source = "./modules/cloudfront"
#
#    target_origin_id = var.cf_target_origin_id 
#    origin_domain_name = module.s3_media.bucket_domain_name
#}


module "vpc" {
    source = "./modules/vpc"

    vpc_name = "Lab-WP-HA"
    vpc_cidr  = var.vpc_cidr
    networks = var.vpc_networks 
}