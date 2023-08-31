module "lambda" {
  source = "../Lambda"
}

resource "aws_api_gateway_rest_api" "HelloWorldAPI" {
  name = "hello-world-api"
}

# resource "aws_api_gateway_rest_api" "HelloWorldAPI" {
#   body = jsonencode({
#     openapi = "3.0.1"
#     info = {
#       title   = "hello world"
#       version = "1.0"
#     }
#     paths = {
#       "/hello" = {
#         get = {
#           x-amazon-apigateway-integration = {
#             httpMethod           = "GET"
#             payloadFormatVersion = "1.0"
#             type                 = "HTTP_PROXY"
#             uri                  = "https://ip-ranges.amazonaws.com/ip-ranges.json"
#           }
#         }
#       }
#     }
#   })

#   description = "Gets the hello world response"
#   name        = "hello-world"

#   endpoint_configuration {
#     types = ["REGIONAL"]
#   }
# }

resource "aws_api_gateway_resource" "helloResource" {
  rest_api_id = aws_api_gateway_rest_api.HelloWorldAPI.id
  parent_id   = aws_api_gateway_rest_api.HelloWorldAPI.root_resource_id # In this case, the parent id should the gateway root_resource_id.
  path_part   = "hello"
}

resource "aws_api_gateway_method" "GetHelloWorldMethod" {
  rest_api_id   = aws_api_gateway_rest_api.HelloWorldAPI.id
  resource_id   = aws_api_gateway_resource.helloResource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration" {
  rest_api_id             = aws_api_gateway_rest_api.HelloWorldAPI.id
  resource_id             = aws_api_gateway_resource.helloResource.id
  http_method             = aws_api_gateway_method.GetHelloWorldMethod.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = module.lambda.invokeArn
}

# resource "aws_api_gateway_method_response" "response_200" {
#   rest_api_id = aws_api_gateway_rest_api.HelloWorldAPI.id
#   resource_id = aws_api_gateway_resource.helloResource.id
#   http_method = aws_api_gateway_method.GetHelloWorldMethod.http_method
#   status_code = "200"
# }