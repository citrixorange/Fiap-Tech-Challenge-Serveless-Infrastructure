variable "aws_api_gateway_name" {
    type        = string
    default     = "tech-challenge-api-gateway"
    description = "Api Gateway Name"
}

variable "signup_route" {
    type        = string
    default     = "POST /create-user"
    description = "Route for Sign Up Users"
}

variable "pedido_route" {
    type        = string
    default     = "POST /pedido/criar"
    description = "Route for Pedidos"
}

variable "api_gateway_stage_name" {
    type        = string
    default     = "signup-stage"
    description = "Stage for Sign Up"
}

variable "aws_lambda_invoke_arn" {
    type        = string
    description = "aws_lambda_invoke_arn"
}