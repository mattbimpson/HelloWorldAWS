resource "aws_iam_role" "lambdaRole" {
  name = "serverless_lambda"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Sid    = ""
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambdaRole.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

data "archive_file" "lambda_zip" {
  type = "zip"

  source_dir  = "../Lambda/build"
  output_path = "./lambda-output.zip"
}

resource "aws_lambda_function" "helloWorldLambda" {
  function_name    = "hello-world"
  filename         = "./lambda-output.zip"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  handler          = "index.handler"
  role             = aws_iam_role.lambdaRole.arn
  runtime          = "nodejs14.x"
}

resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.helloWorldLambda.function_name
  principal     = "apigateway.amazonaws.com"
}

output "invokeArn" {
  value = aws_lambda_function.helloWorldLambda.invoke_arn
}