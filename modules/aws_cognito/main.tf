provider "aws" {
  region = "us-east-1"
}

resource "aws_cognito_user_pool" "user_pool" {
  name = var.user_pool_name
  
  // Configure self sign-up without requiring a password
  auto_verified_attributes = ["email"]
  
  admin_create_user_config {
    allow_admin_create_user_only = true
  }

  schema {
    name = "email"
    attribute_data_type = "String"
    required = true
  }

  schema {
    name = "name"
    attribute_data_type = "String"
    required = true
  }

  schema {
    name = "cpf"
    attribute_data_type = "String"
    required = false
    mutable = false
    developer_only_attribute = false
    string_attribute_constraints {
      min_length = 11
      max_length = 11
    }
  }
  
}

resource "aws_cognito_user_pool_client" "user_pool_client" {
  name                     = var.user_pool_client_name
  user_pool_id             = aws_cognito_user_pool.user_pool.id
  generate_secret          = false
  callback_urls = var.signup_success_callback_urls
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows = ["implicit"]
  allowed_oauth_scopes = ["openid"]
  supported_identity_providers = ["COGNITO"]
}

resource "aws_cognito_user_pool_domain" "user_pool_domain" {
  domain = var.cognito_user_pool_domain
  user_pool_id = aws_cognito_user_pool.user_pool.id
}