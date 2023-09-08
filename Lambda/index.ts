import { APIGatewayProxyEvent, APIGatewayProxyResult, Handler } from 'aws-lambda';

export const handler: Handler = async (_event: APIGatewayProxyEvent): Promise<APIGatewayProxyResult> => {

  return await new Promise((res) => {
    res({
      body: 'Hello world!',
      statusCode: 200
    });
  })
}