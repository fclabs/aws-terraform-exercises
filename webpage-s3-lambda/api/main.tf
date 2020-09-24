
## Search lambda function
data "aws_lambda_function" "func" {
    function_name = var.lambda_function_name
}

## Create the HTTP API Gateway
resource "aws_apigatewayv2_api" "api" {
    name          = var.api_gateway_name
    protocol_type = "HTTP"
    target = data.aws_lambda_function.func.arn
}

resource "aws_lambda_permission" "apigw" {
    statement_id  = "AllowAPIGatewayInvoke"
    action        = "lambda:InvokeFunction"
    function_name = var.lambda_function_name
    principal     = "apigateway.amazonaws.com"

    source_arn = "${aws_apigatewayv2_api.api.execution_arn}/*/*"
}



resource "local_file" "index_html" {
    content = templatefile( "../templates/index.html.tpl" ,  
        {
            api_endpoint = aws_apigatewayv2_api.api.api_endpoint
        }
    ) 
    filename = "../site/index.html" 
    depends_on = [
        aws_apigatewayv2_api.api
    ]
}
