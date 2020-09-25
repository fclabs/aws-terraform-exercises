
## Search Lambda Role
data "aws_iam_role" "lambda_role" {
    name = var.lambda_role_name
}

## Create the lambda function
resource "aws_lambda_function" "func" {
    filename      = var.lambda_function_payload
    function_name = var.lambda_function_name
    role          = data.aws_iam_role.lambda_role.arn
    handler       = "repo2s3.lambda_handler"

    source_code_hash = filebase64sha256(var.lambda_function_payload)

    runtime = "python3.8"

    environment {
        variables = {
            s3BucketName = local.bucket_name
            codecommitRegion = var.aws_region
            repository = local.codecommit_repo
            branch = var.codecommit_branch
        }
    }
}
