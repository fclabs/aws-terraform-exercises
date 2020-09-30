
locals {
    lambda_policy = <<PROFILE
{
    "Version": "2012-10-17",
    "Statement": [
        { 
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents",
                "ssm:GetParameter*",
                "ssm:GetParametersByPath"
            ],
            "Resource": "*"
        }
    ]
}
PROFILE
}

module "lambda_roles" {
    source = "../../modules/iam-lambda-roles"

    lambda_profiles = [
        {
            name = var.iam_lambda_role_name
            policy = local.lambda_policy
        }
    ]
}