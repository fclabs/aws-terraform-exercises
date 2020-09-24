
## Search for an AWS Predefined policy 
data "aws_iam_policy" "lambda_policy" {
    arn = var.lambda_function_run_policy_arn
}

## create and ad-hpc Role for my Lambda function
module "lambda_roles" {
    source = "../../modules/iam-lambda-roles"

    lambda_profiles = [ 
        { 
            name = var.iam_lambda_role_name
            policy = data.aws_iam_policy.lambda_policy.policy
        }
    ]  
}