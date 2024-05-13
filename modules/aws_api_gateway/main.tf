provider "aws" {
    region = "us-east-1"
}

resource "aws_apigatewayv2_api" "tech_challenge_api_gateway" {
    name          = var.aws_api_gateway_name
    protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "tech_challenge_api_gateway" {
    api_id             = aws_apigatewayv2_api.tech_challenge_api_gateway.id
    integration_type   = "AWS_PROXY"
    integration_method = "POST"
    integration_uri    = var.aws_lambda_invoke_arn
}

resource "aws_apigatewayv2_route" "signup_route" {
    api_id    = aws_apigatewayv2_api.tech_challenge_api_gateway.id
    route_key = var.signup_route
    target    = "integrations/${aws_apigatewayv2_integration.tech_challenge_api_gateway.id}"
}

resource "aws_apigatewayv2_route" "pedido_route" {
    api_id    = aws_apigatewayv2_api.tech_challenge_api_gateway.id
    route_key = var.pedido_route
    target    = "integrations/${aws_apigatewayv2_integration.tech_challenge_api_gateway.id}"
}

resource "aws_apigatewayv2_stage" "tech_challenge_api_gateway" {
    api_id      = aws_apigatewayv2_api.tech_challenge_api_gateway.id
    name        = var.api_gateway_stage_name
    auto_deploy = true
}