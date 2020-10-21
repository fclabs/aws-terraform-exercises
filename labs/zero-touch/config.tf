

variable aws_region { type = string }

variable lab_name { type = string }

# repo config
variable repo_name { type = string }
variable repo_master { type = string }
variable repo_branch_plan { type = string }

# AMI
variable terraform_download_url { type = string }
variable instance_type { type = string }
variable ami_name { type = string }

provider "aws" {
    region     = var.aws_region
}

data "aws_caller_identity" "current" {}


# Calculates variables
locals {
    # Base Policy for Lambda functions 
    lambda_function_run_policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
    
    user_group_admins = "${var.lab_name}-ZTP-Admins"
    user_group_devels = "${var.lab_name}-ZTP-Devels"

    instance_profile_apply = "${var.lab_name}-ZTP-EC2-Apply"
    instance_profile_plan = "${var.lab_name}-ZTP-EC2-Plan"

    aws_account_id = data.aws_caller_identity.current.account_id
}