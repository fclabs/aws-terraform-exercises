resource "aws_s3_bucket" "new" {
    count = var.s3_create ? 1 : 0

    bucket = var.bucket
    acl = var.bucket_acl


    dynamic "website" {
        for_each = var.website
        
        content {
            index_document = website.value[ "index_document" ]
            error_document = website.value[ "error_document" ]
            routing_rules = website.value[ "routing_rules" ]
        }
    }
}
# Create the bucket to block public ACLs only on creation
resource "aws_s3_bucket_public_access_block" "b_pub" {
    count = var.s3_create ? 1 : 0
    
    bucket = aws_s3_bucket.new[0].id

    block_public_acls   = !var.bucket_public
    block_public_policy = !var.bucket_public
    ignore_public_acls  = !var.bucket_public
    restrict_public_buckets  = !var.bucket_public
}

data "aws_s3_bucket" "old" {
    count = !var.s3_create ? 1 : 0

    bucket = var.bucket
}

locals {
    a_bucket = var.s3_create ? aws_s3_bucket.new[0] : data.aws_s3_bucket.old[0]
}

# If the bucket policy is defined, then apply it to the bucket
resource "aws_s3_bucket_policy" "b_policy" {
    count = length( var.bucket_policy )  

    bucket = local.a_bucket.bucket
    policy = var.bucket_policy[count.index]
 
}
