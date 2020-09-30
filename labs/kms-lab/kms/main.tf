### KMS Resource group
## . Creates the Key policy allowing the root account and Admis to manage the Key
## . Creates the Key and get the ARN
## . Creates an EC2 Profile to access the KMS keys. This will create a Role named as the profile

## 2. Create the keys with a profile that Allows 


## Creates a new instance profile with it's role. Both have the same name
## Teh Role will be referenced in teh key policy
## The role ARN will be "arn:aws:iam::123456789012:role/Name",
# Local with policy definition
locals {
    kms_instance_policy = <<EOP
{
  "Version": "2012-10-17",
  "Statement": {
    "Effect": "Allow",
    "Action": [
      "kms:ListKeys",
      "kms:ListAliases"
    ],
    "Resource": "*"
  }
}
EOP
}
# Profile creation. Implicit Role creation with the same name
module "iam_ec2_prof_kms_usage" {
    source = "../../modules/iam-ec2-profile"

    instance_profiles = [
        {
            name = var.iam_instance_profile_name
            
            policy = local.kms_instance_policy
        }
    ]
}
##

## KMS Policy creation
module "aPol" {
    source = "../../modules/iam-kms-policy"
    
    kms_root_arn = "\"arn:aws:iam::${var.aws_account_id}:root\"" 
    kms_admin_arns = [ for u in var.aws_admin_users : "arn:aws:iam::${var.aws_account_id}:user/${u}" ]
    kms_usage_arns = [ "arn:aws:iam::${var.aws_account_id}:role/${var.iam_instance_profile_name}" ]
}
##

## Create the key
resource "aws_kms_key" "lab_key" {
    description = "${var.lab_name} - Key"

    policy = module.aPol.kms_policy
}

## Create an alias to the key
resource "aws_kms_alias" "lab_key_alias" {
  name          = "alias/${var.lab_name}"
  target_key_id = aws_kms_key.lab_key.key_id
}