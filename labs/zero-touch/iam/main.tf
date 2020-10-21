## Search for an AWS Predefined policy 
data "aws_iam_policy" "lambda_policy" {
    arn = local.lambda_function_run_policy_arn
}
## Attach the basic policy
module "lambda_roles" {
    source = "../../modules/iam-lambda-roles"

    lambda_profiles = [
        {
            name = var.lambda_role_name
            policy = data.aws_iam_policy.lambda_policy.policy
        }
    ]
}

