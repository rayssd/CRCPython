resource "aws_apigatewayv2_api" "VisitorCounterAPI" {
  name                       = "VisitorCounterAPI"
  description                = "This is my API for visitor counter"
  protocol_type              = "HTTP"
  route_selection_expression = "$request.method $request.path"

  cors_configuration {
    allow_credentials = false
    allow_headers     = []
    allow_methods     = []
    allow_origins = [
      "*",
    ]
    expose_headers = []
    max_age        = 0
  }
}

resource "aws_apigatewayv2_integration" "VisitorCounter_Lambda" {
  api_id                 = aws_apigatewayv2_api.VisitorCounterAPI.id
  connection_type        = "INTERNET"
  integration_method     = "POST"
  integration_type       = "AWS_PROXY"
  integration_uri        = aws_lambda_function.VisitorCounter.arn
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.VisitorCounterAPI.id
  name        = "$default"
  auto_deploy = true
}
