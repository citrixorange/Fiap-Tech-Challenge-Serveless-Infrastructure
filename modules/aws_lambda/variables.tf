variable "lambda_signup_filename" {
    type        = string
    default     = "signup.zip"
    description = "Lambda Function Source Zipped."
}

variable "lambda_auth_filename" {
    type        = string
    default     = "auth.zip"
    description = "Lambda Function Source Zipped."
}

variable "lambda_signup_function_name" {
    type        = string
    default     = "signupLambdaFunction"
    description = "Lambda Function Name."
}

variable "lambda_auth_function_name" {
    type        = string
    default     = "authLambdaFunction"
    description = "Lambda Function Name."
}

variable "lambda_function_runtime" {
    type        = string
    default     = "python3.8"
    description = "Lambda Function Name."
}

variable "lambda_iam_role_name" {
    type        = string
    default     = "Signup-Lambda-Role"
    description = "Lambda Iam Role Name."
}

variable "lambda_iam_role_version" {
    type        = string
    default     = "2012-10-17"
    description = "Lambda Iam Role Version."
}

variable "lambda_iam_policy_name" {
    type        = string
    default     = "Signup-Policy"
    description = "Lambda Iam Policy Name."
}

variable "aws_api_gateway_execution_arn" {
    type        = string
    description = "aws_api_gateway_execution_arn"
}

variable "cognito_arn" {
    type        = string
    description = "cognito_arn"
}

variable "user_pool_id" {
    type        = string
    description = "user_pool_id"
}

variable "user_pool_default_password" {
    type        = string
    description = "user_pool_default_password"
}