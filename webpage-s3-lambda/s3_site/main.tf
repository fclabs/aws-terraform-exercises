
## Creaste a list of files to upload
locals {
    bucket_name = "www.${var.dns_zone}"
    abs_path = abspath( var.site_path ) 
    file_list = fileset( local.abs_path , "**" )
    bucket_policy = <<EOP
{
    "Version": "2012-10-17",
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
        }
    ]
}
EOP
}

### Create S3 buckets
module "s3_site" {
    source = "../../modules/s3"
    bucket = local.bucket_name

    bucket_acl = "public-read"
    bucket_public = true
    bucket_policy = [local.bucket_policy]

    website = [
        {
            index_document = "index.html"
            error_document = "error.html"
            routing_rules = ""
        }
    ]
}

module "mime_guest" {
    source = "../../modules/file-mime-guess"

    files = local.file_list
}
# Output list of file_mime map { file: , mime_type: }

resource "aws_s3_bucket_object" "aFile" {
    count = length( module.mime_guest.file_mimes ) 

    bucket = module.s3_site.bucket
    key = lookup( module.mime_guest.file_mimes[ count.index ] , "file" )
    content_type = lookup( module.mime_guest.file_mimes[ count.index ] , "mime" )
    source = "${local.abs_path}/${lookup( module.mime_guest.file_mimes[ count.index ] , "file" )}"

} 

# Register the bucket FQDN as www record on DNS zone 
module "dns_record_media" {
    source = "../../modules/route53"

    zone = var.dns_zone
    records = [
        {
            name = "www"
            ttl = 60
            type = "CNAME"
            values = [ module.s3_site.bucket_website_endpoint ]           
        }
    ]
}  

