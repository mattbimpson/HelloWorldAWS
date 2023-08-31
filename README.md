# Hello World with AWS
## This is a simple repo showing how to make a small application using AWS API Gateway and AWS Lambda. The tutorial contains source code for the lambda, and terraform scripts for the deployment.

## Some setup
- To run the terraform scripts, first add the following env variables to your terminal environment, if not already configured in an aws config file:

export AWS_ACCESS_KEY_ID=your_aws_access_key
export AWS_SECRET_ACCESS_KEY=your_aws_secret_access_key

- Run 'terraform plan' to preview any changes to be made by terraform
- Run 'terraform apply' to deploy your changes