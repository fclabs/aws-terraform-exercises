# validation.tf 

#########################################################A
### SECRETS

variable "aws_access_key" { type = string }
variable "aws_secret_key" { type = string }

variable "aws_s3_backend_bucket" { type = string }

variable "aws_account_id" { type = string }
variable "terraform_user" { type = string }

### Define Secret valies in secrets.auto.tfvars (not included in git repo)
#########################################################A

provider "aws" {
  access_key = var.aws_access_key 
  secret_key = var.aws_secret_key 
  region     = "us-east-1"
}


module "s3_backend" {
    source = "../modules/setup-s3-backend"

    name = "fclabs-lab-terraform-state"
    terraform_arn = "arn:aws:iam::${var.aws_account_id}:user/${var.terraform_user}"
}

output "bucker_name" {
    value = module.s3_backend.bucket_name
}
output "dynamodb_name" {
    value = module.s3_backend.dynamodb_name
}
output "bucker_arn" {
    value = module.s3_backend.bucket_arn
}
output "dynamodb_arn" {
    value = module.s3_backend.dynamodb_arn
}
