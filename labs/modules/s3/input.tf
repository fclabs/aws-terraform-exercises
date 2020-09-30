variable "bucket" {
    type = string
    description = "Bucket name"
}
variable "s3_create" {
    type = bool
    default = true
    description = "Define if the bucket must be create or consulted"
}

variable "bucket_policy" {
    type = list(string)
    default = []
    description = "Bucket policy"
}

variable "bucket_public" {
    type = bool
    default = false
    description = "Make the s3 bucket public. Default false"
}

variable "bucket_acl" {
    type = string
    default = "private"
    description = "Canned ACL to setup. Default private"
}

## Map with website block configuration
# 
variable "website" {
    type = list (
        object(
            {
                index_document = string
                error_document = string
                routing_rules = string
            }
        )
    )
    default = []
    description = "Configure Website behavior for S3 bucket"
}

