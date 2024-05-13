provider "aws" {
  region = "us-east-1"
}

resource "aws_lambda_permission" "tech_challenge_signup_lambda" {
    statement_id  = "AllowAPIGatewayInvoke"
    action        = "lambda:InvokeFunction"
    function_name = aws_lambda_function.tech_challenge_signup_lambda.function_name
    principal     = "apigateway.amazonaws.com"
    source_arn    = "${var.aws_api_gateway_execution_arn}/*/*"
}

resource "aws_lambda_permission" "tech_challenge_auth_lambda" {
    statement_id  = "AllowAPIGatewayInvoke"
    action        = "lambda:InvokeFunction"
    function_name = aws_lambda_function.tech_challenge_auth_lambda.function_name
    principal     = "apigateway.amazonaws.com"
    source_arn    = "${var.aws_api_gateway_execution_arn}/*/*"
}

resource "aws_lambda_function" "tech_challenge_signup_lambda" {
    filename      = var.lambda_signup_filename
    function_name = var.lambda_signup_function_name
    handler       = "signup.lambda_handler"
    runtime       = var.lambda_function_runtime
    role          = aws_iam_role.tech_challenge_signup_lambda.arn
    environment {
        variables = {
            user_pool_id = var.user_pool_id,
            user_pool_default_password = var.user_pool_default_password
        }
    }
}

resource "aws_lambda_function" "tech_challenge_auth_lambda" {
    filename      = var.lambda_auth_filename
    function_name = var.lambda_auth_function_name
    handler       = "auth.lambda_handler"
    runtime       = var.lambda_function_runtime
    role          = aws_iam_role.tech_challenge_signup_lambda.arn
    environment {
        variables = {
            user_pool_id = var.user_pool_id,
            arn = var.aws_api_gateway_execution_arn
        }
    }
}

resource "aws_iam_role" "tech_challenge_signup_lambda" {
    name = var.lambda_iam_role_name

    assume_role_policy = jsonencode({
        Version = var.lambda_iam_role_version
        Statement = [{
            Effect    = "Allow"
            Principal = {
                Service = "lambda.amazonaws.com"
            }
            Action = "sts:AssumeRole"
        }]
    })

    inline_policy {
        name = var.lambda_iam_policy_name

        policy = jsonencode({
            Version = var.lambda_iam_role_version
            Statement = [{
                Effect    = "Allow"
                Action    = "logs:*"
                Resource  = "*"
            },		
            {
			    "Effect": "Allow",
			    "Action": [
				    "cognito-idp:AdminCreateUser",
                    "cognito-idp:AdminGetUser"
			    ],
			    "Resource": var.cognito_arn
		    }]
        })
    }
}