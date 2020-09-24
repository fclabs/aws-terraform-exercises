

#########################################################A
### SECRETS

variable "aws_access_key" { type = string }
variable "aws_secret_key" { type = string }

variable "aws_admin_users" { type = list(string) }
variable "aws_account_id" { type = string }
variable "dns_zone" { type = string }


### Define Secret valies in secrets.auto.tfvars (not included in git repo)
#########################################################A


variable "aws_region"  { type = string }
variable "lab_name" { type = string }

variable "iam_lambda_role_name" { type = string }
variable "lambda_function_name" { type = string }
variable "lambda_function_payload" { type = string }
variable "lambda_function_run_policy_arn" { type = string }

variable "api_gateway_name" { type = string }

variable "site_path" { type = string }


provider "aws" {
    access_key = var.aws_access_key 
    secret_key = var.aws_secret_key 
    region     = var.aws_region
}

