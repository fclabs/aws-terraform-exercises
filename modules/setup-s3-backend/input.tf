
variable "name" {
    type = string
    description = "State context name. Mandatory"
}

variable "terraform_arn" {
    type = string
    description = "User that will access S3 terraform state bucket"
}
