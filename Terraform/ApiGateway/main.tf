module "lambda" {
  source = "../Lambda"
}

resource "aws_api_gateway_rest_api" "HelloWorldAPI" {
  name = "hello-world-api"
}

resource "aws_api_gateway_resource" "helloResource" {
  rest_api_id = aws_api_gateway_rest_api.HelloWorldAPI.id
  parent_id   = aws_api_gateway_rest_api.HelloWorldAPI.root_resource_id # The parent id should the gateway root_resource_id
  path_part   = "hello"
}

resource "aws_api_gateway_method" "GetHelloWorldMethod" {
  rest_api_id   = aws_api_gateway_rest_api.HelloWorldAPI.id
  resource_id   = aws_api_gateway_resource.helloResource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "Integration" {
  rest_api_id             = aws_api_gateway_rest_api.HelloWorldAPI.id
  resource_id             = aws_api_gateway_resource.helloResource.id
  http_method             = aws_api_gateway_method.GetHelloWorldMethod.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = module.lambda.invokeArn
}

resource "aws_api_gateway_deployment" "DeploymentDev" {
  depends_on    = [aws_api_gateway_rest_api.HelloWorldAPI]
  rest_api_id   = aws_api_gateway_rest_api.HelloWorldAPI.id
  stage_name    = "dev"
}
