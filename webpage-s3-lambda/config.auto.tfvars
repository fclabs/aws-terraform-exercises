
aws_region = "us-east-1"

lab_name = "Lab_S3_Lambda_Webpage"

iam_lambda_role_name = "Lab-WWW-Site-Func-Hello-Role"

lambda_function_name = "Lab-WWW-Site-Func-Hello"
lambda_function_payload = "hello.zip"

lambda_function_run_policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"

api_gateway_name = "Lab-WWW-Site-API-GW-Hello"

# Relative to the ./s3_site folder
site_path = "../site"
