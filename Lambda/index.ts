import { APIGatewayProxyEvent, APIGatewayProxyResult, Handler } from 'aws-lambda';

export const HelloWorldHandler: Handler = async (_event: APIGatewayProxyEvent): Promise<APIGatewayProxyResult> => {
  
  return await new Promise((res) => {
    res({
      body: 'Hello world!',
      statusCode: 200
    });
  })
}