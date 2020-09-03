

### Create S3 buckets
module "s3-media" {
    source = "./modules/s3"
    bucket = var.bucket_name_media
}

module "s3-code" {
    source = "./modules/s3"
    bucket = var.bucket_name_code
}

