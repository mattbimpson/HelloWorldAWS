import { APIGatewayProxyEvent, APIGatewayProxyResult, Handler } from 'aws-lambda';

const isAuthorised = (event: APIGatewayProxyEvent): boolean => {
  const apiKey = event.headers["x-api-key"];
  if (!apiKey) {
    return false;
  }
  console.log(apiKey);
  return true;
}

export const handler: Handler = async (event: APIGatewayProxyEvent): Promise<APIGatewayProxyResult> => {

  // Note - this would be handled in a lambda authoriser. See https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-use-lambda-authorizer.html
  // For this example, we can just do this inline with our lambda here.
  isAuthorised(event);

  return await new Promise((res) => {
    res({
      body: 'Hello world!',
      statusCode: 200
    });
  })
}