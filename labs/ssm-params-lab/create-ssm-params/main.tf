
module "aPol" {
    source = "../../modules/iam-kms-policy"
    
    kms_root_arn = "\"arn:aws:iam::${var.aws_account_id}:root\"" 
    kms_admin_arns = [ for u in var.aws_admin_users : "arn:aws:iam::${var.aws_account_id}:user/${u}" ]
    kms_usage_arns = [ "arn:aws:iam::${var.aws_account_id}:role/${var.iam_lambda_role_name}" ]
}


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

module "params" {
    source = "../../modules/ssm-params"

    params = [
        {
            name = "/dev/myapp/username"
            type = "String"
            value = "fede"
        },
        {
            name = "/prod/myapp/username"
            type = "String"
            value = "db_user"
        },
        {
            name = "/prod/myapp/db_password"
            type = "SecureString"
            value = "aPassword!!"
        },
        {
            name = "/prod/myapp/dbsize"
            type = "String"
            value = "56000"
        },
        {
            name = "/dev/myapp/dbsize"
            type = "String"
            value = "100"
        },
    ]

    depends_on = [
        aws_kms_alias.lab_key_alias
    ]
}