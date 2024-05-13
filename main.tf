module "aws_cognito" {
  source = "./modules/aws_cognito"
}

module "aws_api_gateway" {
  source = "./modules/aws_api_gateway"
  
  aws_lambda_invoke_arn = module.aws_lambda.aws_lambda_invoke_arn
}

module "aws_lambda" {
  source = "./modules/aws_lambda"

  aws_api_gateway_execution_arn = module.aws_api_gateway.aws_api_gateway_execution_arn
  cognito_arn = module.aws_cognito.cognito_arn
  user_pool_id = module.aws_cognito.user_pool_id
  user_pool_default_password = var.password
}

module "aws_vpc" {
  source = "./modules/aws_vpc"
}