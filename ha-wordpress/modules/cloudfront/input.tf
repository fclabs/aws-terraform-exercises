variable "origin_domain_name" {
    type = string
    description = "Specify the domain name for your origin - the Amazon S3 bucket, AWS MediaPackage channel endpoint, AWS MediaStore container endpoint, or web server from which you want CloudFront to get your web content."
}

variable "target_origin_id" {
    type = string
    description = ""
}
