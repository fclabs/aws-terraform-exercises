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
