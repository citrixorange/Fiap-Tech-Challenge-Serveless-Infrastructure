import json
import boto3
import os

def lambda_handler(event, context):
    # Retrieve the custom attribute from the request
    custom_attribute_value = event['queryStringParameters']['cliente']

    # Check if the custom attribute exists in Cognito User Pool
    if custom_attribute_value:
        cognito_client = boto3.client('cognito-idp')
        try:
            response = cognito_client.admin_get_user(
                UserPoolId=os.environ['user_pool_id'],
                Username=custom_attribute_value
            )
            # User with the custom attribute exists, authorize the request
            return generate_policy(True)
        except cognito_client.exceptions.UserNotFoundException:
            # User with the custom attribute does not exist, deny the request
            return generate_policy(False)
    else:
        # Custom attribute not present, deny the request
        return generate_policy(False)

def generate_policy(result):
    policy = {
        "isAuthorized": result
    }
    return policy