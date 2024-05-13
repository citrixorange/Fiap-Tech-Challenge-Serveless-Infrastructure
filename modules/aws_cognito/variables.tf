variable "user_pool_name" {
    type        = string
    default     = "tech_challenge_user_pool"
    description = "Cognito User Pool Name"
}

variable "user_pool_client_name" {
    type        = string
    default     = "tech_challenge_user_pool_client_name"
    description = "Cognito User Pool Client Name"
}

variable "signup_success_callback_urls" {
    type        = list(string)
    default     = ["https://example.com"]
    description = "Sign Up Success Callback Url"
}

variable "cognito_user_pool_domain" {
    type        = string
    default     = "tech-challenge-users"
    description = "Cognito User Pool Domain"
}