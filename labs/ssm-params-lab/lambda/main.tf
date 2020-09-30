
### Search Resources
## the Lambda role
data "aws_iam_role" "role" {
    name = var.iam_lambda_role_name
}

resource "aws_lambda_function" "func" {
    filename      = var.lambda_function_payload
    function_name = var.lambda_function_name
    role          = data.aws_iam_role.role.arn
    handler       = "Func.lambda_handler"

    source_code_hash = filebase64sha256(var.lambda_function_payload)

    runtime = "python3.8"

    environment {
        variables = {
            ENV = "prod"
            APP_CONFIG_PATH = "myapp"
        }
    }
}
