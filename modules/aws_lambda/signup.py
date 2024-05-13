import boto3
import json
import os

def lambda_handler(event, context):
    # Extract data from the request body
    request_body = json.loads(event['body'])
    name = request_body.get('name')
    email = request_body.get('email')
    cpf = request_body.get('cpf')

    # Create user in Cognito User Pool
    client = boto3.client('cognito-idp')
    response = client.admin_create_user(
        UserPoolId=os.environ['user_pool_id'],
        Username=name,
        UserAttributes=[
            {'Name': 'email', 'Value': email},
            {'Name': 'custom:cpf', 'Value': cpf}
            # Add any additional attributes here
        ],
        TemporaryPassword=os.environ['user_pool_default_password'],#'TEMPoRaRY_PASSWORD@12345',
        MessageAction='SUPPRESS'  # Suppress sending invitation email
    )

    return {
        'statusCode': 200,
        'body': json.dumps('User created/updated successfully')
    }
