resource "aws_iam_role" "lambdaRole" {
  name = "example-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_policy" "examplePolicy" {
  name        = "example-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
      Resource = ["arn:aws:logs:*:*:*"]
    },{
      Effect = "Allow"
      Action = [
        "ec2:CreateNetworkInterface",
        "ec2:DescribeNetworkInterfaces",
        "ec2:DeleteNetworkInterface"
      ]
      Resource = ["*"]
    }]
  })
}

resource "aws_iam_role_policy_attachment" "examplePolicyAttachment" {
  policy_arn = aws_iam_policy.examplePolicy.arn
  role = aws_iam_role.lambdaRole.name
}

resource "aws_lambda_function" "helloWorldLambda" {
  function_name    = "hello-world"
  filename         = "hello-world-lambda_payload.zip"
  source_code_hash = filebase64sha256("hello-world-lambda_payload.zip")
  handler          = "index.handler"
  role             = aws_iam_role.lambdaRole.arn
  runtime          = "nodejs14.x"
  # vpc_config {
  #   subnet_ids = [aws_subnet.example.id]
  #   security_group_ids = [aws_security_group.example.id]
  # }
}

output "invokeArn" {
  value = aws_lambda_function.helloWorldLambda.invoke_arn
}